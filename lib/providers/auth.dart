import "dart:convert";

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
  bool isForceUpdatePending = false;
  bool isGuest = true;
  String? token;
  models.User? user;
  models.Player? player;
  models.Settings settings = models.Settings();
  List<models.FAQ>? faqs;

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
    if (savedEssentials != null) {
      utilities.Global.essentials = savedEssentials;
    }

    api.EssentialsResponse response;
    while (true) {
      response = await api.CommonRequests.essentials();
      if (response.success) break;
      await Future.delayed(const Duration(seconds: 1));
    }

    utilities.Database.saveEssentials(response.data!);
    utilities.Global.essentials = response.data!;
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

    if (!response.success) {
      return data_classes.SignInProviderResponse(
        result: false,
        errorCode: 5,
        errorMessage: "Login failure, try again later",
      );
    }

    final loginData = response.data!;
    user = loginData.user;
    token = loginData.token;
    player = loginData.player;

    utilities.api.options.headers["authorization"] = "Bearer $token";
    utilities.Global.isAuthenticated = true;
    if (player != null) utilities.Global.isPlayerConnected = true;
    _recordLoginAnalytics();

    // upon successful login, send deviceDetail to server
    _sendDeviceDetail();
    // save response in local db
    _saveResponse(loginData);

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
      if (!result.success) {
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
    int playerId,
  ) async {
    final response = await api.AuthRequests.checkPlayerClaimed(
      playerId: playerId,
    );

    return response.data;
  }

  /// Claim a player profile and connect it to the user
  Future<api.ClaimPlayerResponse> claimPlayer(
    String otp,
    int playerId,
  ) async {
    // Sends an otp and playerId to server to check
    // if a loadout exists with that OTP
    // if it does, then player is verified

    final verification = utilities.RSACrypto.encryptRSA(otp);

    final response = await api.AuthRequests.claimPlayer(
      verification: verification,
      playerId: playerId,
    );
    if (!response.success) {
      return response;
    }
    final claimPlayerData = response.data!;

    if (claimPlayerData.verified) {
      // if verified, then save the user and player in the provider

      user = claimPlayerData.user;
      player = claimPlayerData.player;
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
    int playerId,
  ) async {
    if (user == null) return data_classes.FavouriteFriendResult.unauthorized;

    final favouriteFriendsClone = List<int>.from(user!.favouriteFriendIds);
    data_classes.FavouriteFriendResult result;

    if (!user!.favouriteFriendIds.contains(playerId)) {
      // player is not in the favouriteFriends, so we need to add him

      // check if user already has max number of friends
      if (user!.favouriteFriendIds.length >=
          utilities.Global.essentials!.maxFavouriteFriends) {
        return data_classes.FavouriteFriendResult.limitReached;
      }

      user!.favouriteFriendIds.add(playerId);
      result = data_classes.FavouriteFriendResult.added;
      utilities.Analytics.logEvent(constants.AnalyticsEvent.markFriend);
    } else {
      // if he is in the favouriteFriends, then remove him
      user!.favouriteFriendIds.remove(playerId);
      result = data_classes.FavouriteFriendResult.removed;
      utilities.Analytics.logEvent(constants.AnalyticsEvent.unmarkFriend);
    }

    notifyListeners();

    // after we update the UI
    // update the favourite friends in backend
    // update the UI for the latest changes from backend

    final response =
        await api.PlayersRequests.updateFavouriteFriend(playerId: playerId);

    if (!response.success) {
      // if the response fails for some reason, revert back the change
      // set newPlayerAdded to false
      user!.favouriteFriendIds = favouriteFriendsClone;
      result = data_classes.FavouriteFriendResult.reverted;
      notifyListeners();
    }

    utilities.Database.saveUser(user!);

    return result;
  }

  void getFAQs() async {
    final response = await api.CommonRequests.faq();
    if (response.success) {
      faqs = response.data;
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
    notifyListeners();
    utilities.Analytics.logEvent(
      constants.AnalyticsEvent.changeTheme,
      {"theme": themeName},
    );
    utilities.Database.saveSettings(settings);
  }

  /// Toggle showUserPlayerMatches for commonMatches
  void toggleShowUserPlayerMatches(bool? value) {
    settings.showUserPlayerMatches = value ?? false;
    notifyListeners();
    utilities.Database.saveSettings(settings);
  }

  /// Set queue region in settings
  void setQueueRegions(String region) {
    settings.selectedQueueRegion = region;
    notifyListeners();
    utilities.Database.saveSettings(settings);
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

  /// Send device details to server
  Future<void> _sendDeviceDetail() async {
    final deviceDetail = await utilities.getDeviceDetail();

    if (deviceDetail != null) {
      await api.AuthRequests.registerDevice(
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

  void _saveResponse(data_classes.LoginData loginData) {
    utilities.Database.saveUser(loginData.user);
    utilities.Database.saveToken(loginData.token);
    if (loginData.player != null) {
      utilities.Database.savePlayer(loginData.player!);
    }
  }
}

/// Provider to handle auth and user data
final auth = ChangeNotifierProvider((ref) => _AuthNotifier(ref: ref));
