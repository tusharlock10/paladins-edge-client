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
import "package:paladinsedge/dev/index.dart" as dev;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/champions.dart" as champions_provider;
import "package:paladinsedge/providers/loadout.dart" as loadout_provider;
import "package:paladinsedge/providers/matches.dart" as matches_provider;
import "package:paladinsedge/providers/players.dart" as players_provider;
import "package:paladinsedge/utilities/index.dart" as utilities;

class _GetFirebaseUserResponse {
  final UserCredential? firebaseUser;
  final int? errorCode;
  final String? errorMessage;

  _GetFirebaseUserResponse({
    this.firebaseUser,
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
  bool isGuest = true;
  String? token;
  models.User? user;
  models.Player? player;
  models.Settings settings = models.Settings();
  List<models.FAQ>? faqs;
  List<data_classes.CombinedMatch>? savedMatches;

  _AuthNotifier({required this.ref});

  void setAppInitialized() {
    isInitialized = true;
    notifyListeners();
  }

  /// gets the list of locally available paladinsAssets
  Future<void> loadPaladinsAssets() async {
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

  /// Loads the `settings` from local db
  void loadSettings() {
    settings = utilities.Database.getSettings();
    notifyListeners();
  }

  /// Loads and the `essentials` from local db and syncs it with server
  Future<void> loadEssentials() async {
    // gets the essential data for the app

    // getting the essential data from local until the api call is completed
    final savedEssentials = utilities.Database.getEssentials();

    api.EssentialsResponse? response;
    while (true) {
      response = await api.AuthRequests.essentials();
      if (response == null && savedEssentials != null) {
        utilities.Global.essentials = savedEssentials;

        return;
      }
      if (response != null) break;
    }

    utilities.Database.saveEssentials(response.essentials);
    utilities.Global.essentials = response.essentials;
  }

  /// Checks if the user is already logged in
  bool checkLogin() {
    token = utilities.Database.getToken();
    user = utilities.Database.getUser();
    player = utilities.Database.getPlayer();

    utilities.Global.isPlayerConnected = player != null;

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
    final String uid, email, name;
    if (dev.testUser == null) {
      final firebaseUserResponse = await _getFirebaseUser();
      final firebaseUser = firebaseUserResponse.firebaseUser;

      if (firebaseUserResponse.errorCode == 0) {
        // user has closed the popup window
        return data_classes.SignInProviderResponse(result: false);
      }

      if (firebaseUser == null) {
        return data_classes.SignInProviderResponse(
          result: false,
          errorCode: firebaseUserResponse.errorCode,
          errorMessage: firebaseUserResponse.errorMessage,
        );
      }
      uid = firebaseUser.user!.uid;
      email = firebaseUser.user!.email!;
      name = firebaseUser.user!.displayName!;
    } else {
      // in development use test user
      uid = dev.testUser!.uid;
      email = dev.testUser!.email;
      name = dev.testUser!.name;
    }

    final verification = utilities.RSACrypto.encryptRSA("$name$email$uid");

    final response = await api.AuthRequests.login(
      uid: uid,
      email: email,
      name: name,
      verification: verification,
    );

    if (response == null) {
      return data_classes.SignInProviderResponse(
        result: false,
        errorCode: 5,
        errorMessage: "Login failure, try again later",
      );
    }

    user = response.user;
    token = response.token;
    player = response.player;

    utilities.api.options.headers["authorization"] = "Bearer $token";
    utilities.Global.isAuthenticated = true;
    if (player != null) utilities.Global.isPlayerConnected = true;
    _recordLoginAnalytics();

    // upon successful login, send FCM token and deviceDetail to server
    _sendFCMToken();
    _sendDeviceDetail();
    // save response in local db
    _saveResponse(response);

    isGuest = false;
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

    try {
      await GoogleSignIn().signOut();
    } catch (_) {
      return false;
    }

    if (!isGuest) {
      final result = await api.AuthRequests.logout();
      if (!result) {
        return false;
      }
      utilities.Analytics.logEvent(constants.AnalyticsEvent.userLogout);
    } else {
      utilities.Analytics.logEvent(constants.AnalyticsEvent.guestLogin);
    }

    // clear data from all providers
    clearData();
    ref.read(champions_provider.champions).clearData();
    ref.read(loadout_provider.loadout).clearData();
    ref.read(matches_provider.matches).clearData();
    ref.read(players_provider.players).clearData();

    // clear values from the database and utilities
    utilities.Database.clear();

    utilities.api.options.headers["authorization"] = null;
    utilities.Global.isAuthenticated = false;

    return true;
  }

  Future<bool?> checkPlayerClaimed(
    String playerId,
  ) async {
    final response = await api.AuthRequests.checkPlayerClaimed(
      playerId: playerId,
    );

    return response?.exists;
  }

  /// Claim a player profile and connect it to the user
  Future<api.ClaimPlayerResponse?> claimPlayer(
    String otp,
    String playerId,
  ) async {
    // Sends an otp and playerId to server to check
    // if a loadout exists with that OTP
    // if it does, then player is verified

    final verification = utilities.RSACrypto.encryptRSA(otp);

    final response = await api.AuthRequests.claimPlayer(
      verification: verification,
      playerId: playerId,
    );

    if (response != null && response.verified) {
      // if verified, then save the user and player in the provider

      user = response.user;
      player = response.player;
      if (user != null) utilities.Database.saveUser(user!);
      if (player != null) {
        utilities.Database.savePlayer(player!);
        utilities.Global.isPlayerConnected = true;
        utilities.Analytics.logEvent(constants.AnalyticsEvent.claimProfile);
      }

      notifyListeners();
    }

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

    utilities.Database.saveUser(user!);
    notifyListeners();

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
      final matchDetails = ref.read(matches_provider.matches).matchDetails;
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

    utilities.Database.saveUser(user!);
    notifyListeners();

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

  /// Toggle the theme from `light` to `dark` and vice versa
  void toggleTheme(ThemeMode themeMode) {
    settings.themeMode = themeMode;

    String? themeName;
    if (themeMode == ThemeMode.dark) {
      themeName = "dark";
    } else if (themeMode == ThemeMode.light) {
      themeName = "light";
    } else if (themeMode == ThemeMode.system) {
      themeName = "system";
    }
    utilities.Analytics.logEvent(
      constants.AnalyticsEvent.changeTheme,
      {"theme": themeName},
    );

    // save the settings after changing the theme
    utilities.Database.saveSettings(settings);
    notifyListeners();
  }

  void clearData() {
    player = null;
    token = null;
    isGuest = false;
    user = null;
    settings = models.Settings();
  }

  Future<_GetFirebaseUserResponse> _getFirebaseUser() async {
    final GoogleSignInAccount? googleUser;
    try {
      googleUser = await GoogleSignIn().signIn();
    } catch (error) {
      if (error is PlatformException) {
        return _GetFirebaseUserResponse(
          errorCode: 0,
          errorMessage: error.toString(),
        );
      }

      return _GetFirebaseUserResponse(
        errorCode: 1,
        errorMessage: error.toString(),
      );
    }

    if (googleUser == null) {
      return _GetFirebaseUserResponse(
        errorCode: 2,
        errorMessage: "User not found for this Google Account",
      );
    }

    final GoogleSignInAuthentication googleAuth;
    try {
      googleAuth = await googleUser.authentication;
    } catch (error) {
      return _GetFirebaseUserResponse(
        errorCode: 3,
        errorMessage: error.toString(),
      );
    }

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final firebaseUser =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (firebaseUser.user == null ||
        firebaseUser.user?.email == null ||
        firebaseUser.user?.displayName == null) {
      return _GetFirebaseUserResponse(
        errorCode: 4,
        errorMessage: "User not found for this Google Account",
      );
    }

    return _GetFirebaseUserResponse(firebaseUser: firebaseUser);
  }

  /// Send the FCM token to server, only works on `Android`
  /// for sending notification fcm token is used only
  /// for the server, and not stored on the app/ browser
  Future<void> _sendFCMToken() async {
    final fcmToken = await utilities.Messaging.initMessaging();
    if (fcmToken != null) await api.AuthRequests.fcmToken(fcmToken: fcmToken);
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
    if (isGuest = true) {
      utilities.Analytics.logEvent(
        constants.AnalyticsEvent.guestToUserConversion,
      );
    }
    if (user != null) {
      utilities.Analytics.setUserId(user!.uid);
    }
    if (player != null) {
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
final auth = ChangeNotifierProvider((ref) => _AuthNotifier(ref: ref));
