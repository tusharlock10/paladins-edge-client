import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/champions.dart' as champions_provider;
import 'package:paladinsedge/providers/loadout.dart' as loadout_provider;
import 'package:paladinsedge/providers/matches.dart' as matches_provider;
import 'package:paladinsedge/providers/players.dart' as players_provider;
import 'package:paladinsedge/utilities/index.dart' as utilities;

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
  bool isGuest = false;
  String? token;
  models.User? user;
  models.Player? player;
  models.Settings settings = models.Settings();

  _AuthNotifier({required this.ref});

  /// Loads the `settings` from local db
  void loadSettings() {
    settings = utilities.Database.getSettings();
    utilities.postFrameCallback(notifyListeners);
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
  Future<bool> login() async {
    token = utilities.Database.getToken();
    user = utilities.Database.getUser();
    player = utilities.Database.getPlayer();

    if (token != null) {
      utilities.api.options.headers["authorization"] = token;

      return true;
    } else {
      return false;
    }
  }

  /// Sign-in the user with his/her `Google` account
  Future<data_classes.SignInProviderResponse> signInWithGoogle() async {
    final firebaseUserResponse = await _getFirebaseUser();
    final firebaseUser = firebaseUserResponse.firebaseUser;

    if (firebaseUser == null) {
      return data_classes.SignInProviderResponse(
        result: false,
        errorCode: firebaseUserResponse.errorCode,
        errorMessage: firebaseUserResponse.errorMessage,
      );
    }

    final uid = firebaseUser.user!.uid;
    final email = firebaseUser.user!.email!;
    final name = firebaseUser.user!.displayName!;

    final verification = utilities.RSACrypto.encryptRSA('$name$email$uid');

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
    utilities.Database.saveToken(response.token);
    utilities.Database.saveUser(response.user);
    if (response.player != null) {
      player = response.player;
      utilities.Database.savePlayer(response.player!);
    }

    utilities.api.options.headers["authorization"] = token;

    isGuest = false;
    utilities.postFrameCallback(notifyListeners);

    return data_classes.SignInProviderResponse(result: true);
  }

  /// Login the user as Guest so that he/she can explore the app
  void loginAsGuest() {
    // use firebase to sign-in anonymously
    FirebaseAuth.instance.signInAnonymously();
    isGuest = true;

    utilities.postFrameCallback(notifyListeners);
  }

  /// Logs out the user, also sends this info to server
  Future<bool> logout() async {
    // 1) Clear user's storage first so,
    //    if the logout fails in the steps below
    //    he can still login
    // 2) Sign-out from google
    // 3) Notify backend about logout
    // 4) remove user, player, token from provider

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
    }

    // clear values from the database and provider
    await utilities.Database.clear();

    // providers to clear data from
    ref.read(champions_provider.champions).clearData();
    ref.read(loadout_provider.loadout).clearData();
    ref.read(matches_provider.matches).clearData();
    ref.read(players_provider.players).clearData();

    return true;
  }

  /// Send the FCM token to server, only works on `Android`
  void sendFcmToken(String fcmToken) async {
    // send the fcm token of the device to the server
    // for sending notification fcm token is used only
    // for the server, and not stored on the app/ browser

    api.AuthRequests.fcmToken(fcmToken: fcmToken);
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
      if (player != null) utilities.Database.savePlayer(player!);

      utilities.postFrameCallback(notifyListeners);
    }

    return response;
  }

  /// Marks, un-marks a `friend` player as favourite
  Future<data_classes.FavouriteFriendResult> markFavouriteFriend(
    String playerId,
  ) async {
    if (user == null) return data_classes.FavouriteFriendResult.removed;

    final favouriteFriendsClone = List<String>.from(user!.favouriteFriends);

    if (!user!.favouriteFriends.contains(playerId)) {
      // player is not in the favouriteFriends, so we need to add him

      // check if user already has max number of friends
      if (user!.favouriteFriends.length >=
          utilities.Global.essentials!.maxFavouriteFriends) {
        return data_classes.FavouriteFriendResult.limitReached;
      }

      user!.favouriteFriends.add(playerId);
    } else {
      // if he is in the favouriteFriends, then remove him
      user!.favouriteFriends.remove(playerId);
    }

    utilities.postFrameCallback(notifyListeners);

    // after we update the UI, update the list in backend
    // update the UI for the latest changes

    final response =
        await api.PlayersRequests.favouriteFriend(playerId: playerId);

    if (response == null) {
      // if the response fails for some reason, revert back the change
      // set newPlayerAdded to false
      user!.favouriteFriends = favouriteFriendsClone;
    } else {
      user!.favouriteFriends = response.favouriteFriends;
    }

    utilities.postFrameCallback(notifyListeners);

    return data_classes.FavouriteFriendResult.added;
  }

  /// Toggle the theme from `light` to `dark` and vice versa
  void toggleTheme(ThemeMode themeMode) {
    settings.themeMode = themeMode;

    // save the settings after changing the theme
    utilities.Database.saveSettings(settings);
    utilities.postFrameCallback(notifyListeners);
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
}

/// Provider to handle auth and user data
final auth = ChangeNotifierProvider((ref) => _AuthNotifier(ref: ref));
