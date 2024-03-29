import "dart:convert";

import "package:dartx/dartx.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _GetFirebaseAuthResponse {
  final String? idToken;
  final int? errorCode;
  final String? errorMessage;

  _GetFirebaseAuthResponse({
    this.idToken,
    this.errorCode,
    this.errorMessage,
  });
}

class _AuthNotifier extends ChangeNotifier {
  final ChangeNotifierProviderRef<_AuthNotifier> ref;

  /// checks if the app is initialized
  /// if not, then call widgets.Initialization() widget
  /// once set to true, cannot be false again
  /// all screens are obliged to use this widget
  bool isInitialized = false;
  bool isForceUpdatePending = false;
  bool isGuest = true;
  String? token;
  models.User? user;
  models.Player? userPlayer;
  List<models.FAQ>? faqs;
  List<models.Sponsor>? sponsors;
  List<data_classes.CombinedMatch>? savedMatches;
  bool? apiAvailable = true;

  _AuthNotifier({required this.ref});

  void setAppInitialized() {
    isInitialized = true;
    notifyListeners();
  }

  void setForceUpdatePending() {
    isForceUpdatePending = true;
    notifyListeners();
  }

  /// gets the list of locally available paladinsAssets
  Future<void> loadPaladinsAssets() async {
    if (constants.isWeb) return;

    final manifestContent = await rootBundle.loadString("AssetManifest.json");
    final manifestMap = jsonDecode(manifestContent) as Map<String, dynamic>;
    final allPaladinsAssets = manifestMap.keys.where(
      (_) => _.contains("paladins_assets"),
    );
    final assetTypes = utilities.Global.paladinsAssets.keys;
    for (final asset in allPaladinsAssets) {
      for (final assetType in assetTypes) {
        if (asset.contains(assetType)) {
          utilities.Global.paladinsAssets[assetType]?.add(asset);
          break;
        }
      }
    }
  }

  /// Loads and the `essentials` from local db and syncs it with server
  Future<void> loadEssentials() async {
    // get the essentials from local db
    final savedEssentials = utilities.Database.getEssentials();
    final future = _getEssentials();

    if (savedEssentials != null) {
      // if saved essentials are found, don't wait for future
      utilities.Global.essentials = savedEssentials;
    } else {
      // wait for future, if essentials are not found
      await future;
    }
  }

  /// Checks whether the paladins API is in working state
  Future<void> getApiStatus() async {
    final response = await api.AuthRequests.apiStatus();
    apiAvailable = response?.apiAvailable;

    utilities.postFrameCallback(notifyListeners);
  }

  /// Checks if the user is already logged in
  bool checkLogin() {
    token = utilities.Database.getToken();
    user = utilities.Database.getUser();
    userPlayer = utilities.Database.getPlayer();

    utilities.Global.isPlayerConnected = userPlayer != null;

    if (token != null) {
      isGuest = false;
      utilities.api.options.headers["authorization"] = "Bearer $token";
      utilities.Global.isAuthenticated = true;

      return true;
    } else {
      // if not logged in, then consider the user as a guest
      isGuest = true;

      return false;
    }
  }

  /// Sign-in the user with his/her `Google` account
  Future<data_classes.SignInProviderResponse> signInWithGoogle() async {
    final firebaseAuthResponse = await _getFirebaseAuthCredentials();
    final idToken = firebaseAuthResponse.idToken;

    if (firebaseAuthResponse.errorCode == 0) {
      // user has closed the popup window
      return data_classes.SignInProviderResponse(result: false);
    }

    if (idToken == null) {
      return data_classes.SignInProviderResponse(
        result: false,
        errorCode: firebaseAuthResponse.errorCode,
        errorMessage: firebaseAuthResponse.errorMessage,
      );
    }

    final response = await api.AuthRequests.login(idToken: idToken);

    if (response == null) {
      return data_classes.SignInProviderResponse(
        result: false,
        errorCode: 5,
        errorMessage: "Login failure, try again later",
      );
    }

    user = response.user;
    token = response.token;
    userPlayer = response.player;

    utilities.api.options.headers["authorization"] = "Bearer $token";
    utilities.Global.isAuthenticated = true;
    isGuest = false;
    if (userPlayer != null) utilities.Global.isPlayerConnected = true;

    _recordLoginAnalytics();
    // upon successful login, send FCM token and deviceDetail to server
    _sendDeviceDetail();
    // save response in local db
    _saveResponse(response);

    notifyListeners();

    return data_classes.SignInProviderResponse(result: true);
  }

  /// Login the user as Guest so that he/she can explore the app
  void loginAsGuest() {
    // use firebase to sign-in anonymously
    utilities.Analytics.logEvent(constants.AnalyticsEvent.guestLogin);
    FirebaseAuth.instance.signInAnonymously();
    isGuest = true;

    notifyListeners();
  }

  /// Logs out the user, also sends this info to server
  Future<bool> logout() async {
    // 1) Sign-out from google
    // 2) Notify backend about logout
    // 3) remove user, player, token from provider
    // 4) Clear user's storage

    if (!constants.isWindows) {
      try {
        await GoogleSignIn().signOut();
      } catch (_) {
        return false;
      }
    }

    if (!isGuest && !constants.isWindows) {
      final result = await api.AuthRequests.logout();
      if (!result) return false;
      utilities.Analytics.logEvent(constants.AnalyticsEvent.userLogout);
    } else {
      utilities.Analytics.logEvent(constants.AnalyticsEvent.guestLogin);
    }

    // clear data from all providers
    clearData();
    ref.read(providers.champions).clearData();
    ref.read(providers.loadout).clearData();
    ref.read(providers.appState).clearData();
    ref.read(providers.search).clearData();

    // clear values from the database and utilities
    utilities.Database.clear();

    utilities.api.options.headers["authorization"] = null;
    utilities.Global.isAuthenticated = false;
    isGuest = true;
    if (userPlayer != null) utilities.Global.isPlayerConnected = false;

    notifyListeners();

    return true;
  }

  /// Connect a player profile to the user
  Future<api.ConnectPlayerResponse?> connectPlayer(String playerId) async {
    final response = await api.AuthRequests.connectPlayer(playerId: playerId);
    if (response == null) return null;

    user = response.user;
    userPlayer = response.player;

    utilities.Database.saveUser(response.user);
    utilities.Database.savePlayer(userPlayer!);

    utilities.Global.isPlayerConnected = true;
    utilities.Analytics.logEvent(constants.AnalyticsEvent.connectPlayer);

    notifyListeners();

    return response;
  }

  /// Marks, un-marks a `friend` player as favourite
  Future<data_classes.FavouriteFriendResult> markFavouriteFriend(
    String playerId,
  ) async {
    if (user == null) return data_classes.FavouriteFriendResult.unauthorized;

    final favouriteFriendsClone = List<String>.from(user!.favouriteFriends);
    data_classes.FavouriteFriendResult result;

    if (!user!.favouriteFriends.contains(playerId)) {
      // player is not in the favouriteFriends, so we need to add him

      // check if user already has max number of friends
      if (user!.favouriteFriends.length >=
          utilities.Global.essentials!.maxFavouriteFriends) {
        return data_classes.FavouriteFriendResult.limitReached;
      }

      user!.favouriteFriends.add(playerId);
      result = data_classes.FavouriteFriendResult.added;
      utilities.Analytics.logEvent(constants.AnalyticsEvent.markFriend);
    } else {
      // if he is in the favouriteFriends, then remove him
      user!.favouriteFriends.remove(playerId);
      result = data_classes.FavouriteFriendResult.removed;
      utilities.Analytics.logEvent(constants.AnalyticsEvent.unmarkFriend);
    }

    notifyListeners();

    // after we update the UI
    // update the favourite friends in backend
    // update the UI for the latest changes from backend

    final response =
        await api.PlayersRequests.updateFavouriteFriend(playerId: playerId);

    if (response == null) {
      // if the response fails for some reason, revert back the change
      // set newPlayerAdded to false
      user!.favouriteFriends = favouriteFriendsClone;
      result = data_classes.FavouriteFriendResult.reverted;
    } else {
      user!.favouriteFriends = response.favouriteFriends;
    }

    notifyListeners();
    utilities.Database.saveUser(user!);

    return result;
  }

  /// Saves/ Un-saves a `match` for later reference
  Future<data_classes.SaveMatchResult> saveMatch(
    String matchId,
  ) async {
    if (user == null) return data_classes.SaveMatchResult.unauthorized;

    data_classes.SaveMatchResult result;
    data_classes.CombinedMatch? combinedMatch = savedMatches?.firstOrNullWhere(
      (_) => _.match.matchId == matchId,
    );
    if (combinedMatch == null) {
      final matchDetails = ref.read(providers.matches(matchId)).matchDetails;
      if (matchDetails != null && matchDetails.match.matchId == matchId) {
        combinedMatch = data_classes.CombinedMatch(
          match: matchDetails.match,
          matchPlayers: matchDetails.matchPlayers,
        );
      }
    }
    if (combinedMatch == null) return data_classes.SaveMatchResult.reverted;

    final savedMatchesClone = List<String>.from(user!.savedMatches);

    if (!user!.savedMatches.contains(matchId)) {
      // matchId is not in savedMatches, so we need to add it

      // check if user already has max number of saved matches
      if (user!.favouriteFriends.length >=
          utilities.Global.essentials!.maxSavedMatches) {
        return data_classes.SaveMatchResult.limitReached;
      }

      user!.savedMatches.add(matchId);
      result = data_classes.SaveMatchResult.added;
      savedMatches = [...?savedMatches, combinedMatch];
    } else {
      // if match is in savedMatches, then remove it
      user!.savedMatches.remove(matchId);
      result = data_classes.SaveMatchResult.removed;
      if (savedMatches != null) {
        savedMatches = savedMatches!
            .where(
              (_) => _.match.matchId != matchId,
            )
            .toList();
      }
    }

    notifyListeners();

    // after we update the UI
    // update the saved matches in backend
    // update the UI for the latest changes from backend

    final response = await api.AuthRequests.updateSavedMatches(
      matchId: matchId,
    );

    if (response == null) {
      // if the response fails for some reason, revert back the change
      user!.savedMatches = savedMatchesClone;
      _restoreSavedMatches(combinedMatch, result);

      result = data_classes.SaveMatchResult.reverted;
    } else {
      user!.savedMatches = response.savedMatches;
    }

    notifyListeners();
    utilities.Database.saveUser(user!);

    return result;
  }

  /// Gets all the saved matches for this user
  Future<void> getSavedMatches() async {
    final response = await api.AuthRequests.savedMatches();
    if (response == null) return;

    // create list of combinedMatches using a temp. map
    final Map<String, data_classes.CombinedMatch> tempMatchesMap = {};
    for (final match in response.matches) {
      tempMatchesMap[match.matchId] = data_classes.CombinedMatch(
        match: match,
        matchPlayers: [],
      );
    }
    for (final matchPlayer in response.matchPlayers) {
      final existingCombinedMatch = tempMatchesMap[matchPlayer.matchId];
      if (existingCombinedMatch == null) continue;

      tempMatchesMap[matchPlayer.matchId] = existingCombinedMatch.copyWith(
        matchPlayers: [...existingCombinedMatch.matchPlayers, matchPlayer],
      );
    }

    savedMatches = tempMatchesMap.values.toList();
    if (user != null && savedMatches != null) {
      final matchIds = savedMatches!.map((_) => _.match.matchId);
      user!.savedMatches = matchIds.toList();
      utilities.Database.saveUser(user!);
    }
    notifyListeners();
  }

  void getFAQs() async {
    final response = await api.AuthRequests.faqs();
    if (response != null) {
      faqs = response.faqs;
      notifyListeners();
    }
  }

  void getSponsors() async {
    final response = await api.AuthRequests.getSponsors();
    if (response != null) {
      sponsors = response.sponsors;
      notifyListeners();
    }
  }

  void clearData() {
    userPlayer = null;
    token = null;
    isGuest = false;
    user = null;
  }

  Future<void> _getEssentials() async {
    while (true) {
      final response = await api.AuthRequests.essentials();
      if (response != null) {
        utilities.Global.essentials = response.essentials;
        utilities.Database.saveEssentials(response.essentials);

        return;
      }

      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<_GetFirebaseAuthResponse> _getFirebaseAuthCredentials() async {
    // NOTE: for development login in windows
    if (constants.isWindows && constants.isDebug) {
      return _GetFirebaseAuthResponse(idToken: "testUser");
    }

    final GoogleSignInAccount? googleUser;
    try {
      googleUser = await GoogleSignIn().signIn();
    } catch (error) {
      if (error is PlatformException) {
        return _GetFirebaseAuthResponse(
          errorCode: 0,
          errorMessage: error.toString(),
        );
      }

      return _GetFirebaseAuthResponse(
        errorCode: 1,
        errorMessage: error.toString(),
      );
    }

    if (googleUser == null) {
      return _GetFirebaseAuthResponse(
        errorCode: 2,
        errorMessage: "User not found for this Google Account",
      );
    }

    final GoogleSignInAuthentication googleAuth;
    try {
      googleAuth = await googleUser.authentication;
    } catch (error) {
      return _GetFirebaseAuthResponse(
        errorCode: 3,
        errorMessage: error.toString(),
      );
    }

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final firebaseUser = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    if (firebaseUser.user == null ||
        firebaseUser.user?.email == null ||
        firebaseUser.user?.displayName == null) {
      return _GetFirebaseAuthResponse(
        errorCode: 4,
        errorMessage: "User not found for this Google Account",
      );
    }
    final idToken = await firebaseUser.user!.getIdToken();

    return _GetFirebaseAuthResponse(idToken: idToken);
  }

  /// Send device details to server
  Future<void> _sendDeviceDetail() async {
    final deviceDetail = await utilities.getDeviceDetail();

    if (deviceDetail != null) {
      await api.AuthRequests.deviceDetail(
        deviceDetail: deviceDetail,
      );
    }
  }

  Future<void> _recordLoginAnalytics() async {
    if (isGuest) {
      utilities.Analytics.logEvent(
        constants.AnalyticsEvent.guestToUserConversion,
      );
    }
    if (user != null) utilities.Analytics.setUserId(user!.uid);
    if (userPlayer != null) {
      utilities.Analytics.logEvent(constants.AnalyticsEvent.existingUserLogin);
    } else {
      utilities.Analytics.logEvent(constants.AnalyticsEvent.newUserLogin);
    }
  }

  void _saveResponse(api.LoginResponse response) {
    utilities.Database.saveUser(response.user);
    utilities.Database.saveToken(response.token);
    if (response.player != null) {
      utilities.Database.savePlayer(response.player!);
    }
  }

  void _restoreSavedMatches(
    data_classes.CombinedMatch combinedMatch,
    data_classes.SaveMatchResult result,
  ) {
    if (savedMatches == null) return;

    savedMatches = result == data_classes.SaveMatchResult.added
        ? savedMatches!
            .where((_) => _.match.matchId != combinedMatch.match.matchId)
            .toList()
        : [...savedMatches!, combinedMatch];
  }
}

/// Provider to handle auth and user data
final auth = ChangeNotifierProvider<_AuthNotifier>(
  (ref) => _AuthNotifier(ref: ref),
);
