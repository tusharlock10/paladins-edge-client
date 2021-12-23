import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;

class _AuthNotifier extends ChangeNotifier {
  models.User? user;
  models.Player? player;
  models.Settings settings = models.Settings();

  /// Loads the `settings` from local db
  void loadSettings() {
    settings = utilities.Database.getSettings();
    notifyListeners();
  }

  /// Loads and the `essentials` from local db and syncs it with server
  void loadEssentials() async {
    // gets the essential data for the app

    // getting the essential data from local untill the api call is completed
    utilities.Global.essentials = utilities.Database.getEssentials();

    // call essentials api to update its data
    final response = await api.AuthRequests.essentials();
    if (response != null) {
      utilities.Database.saveEssentials(response.data);
      utilities.Global.essentials = response.data;
    }
  }

  /// Checks if the user is already logged in
  Future<bool> login() async {
    user = utilities.Database.getUser();
    player = utilities.Database.getPlayer();

    if (user?.token != null) {
      utilities.api.options.headers["authorization"] = user!.token;

      return true;
    } else {
      return false;
    }
  }

  /// Signin the user with his/her `Google` account
  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return false;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final firebaseUser =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (firebaseUser.user == null ||
        firebaseUser.user?.email == null ||
        firebaseUser.user?.displayName == null) {
      return false;
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
    // user will have token
    // If player is null, navigate to ConnectProfile

    if (response == null) return false;

    user = response.user;
    utilities.Database.saveUser(response.user);
    if (response.player != null) {
      player = response.player;
      utilities.Database.savePlayer(response.player!);
    }

    utilities.api.options.headers["authorization"] = user!.token;

    return true;
  }

  /// Logs out the user, also sends this info to server
  Future<void> logout() async {
    // 1) Clear user's storage first so,
    //    if the logout fails in the steps below
    //    he can still login
    // 2) Signout from google
    // 3) Notify backend about logout
    // 4) remove user from provider
    // 5) remove player from provider

    utilities.Database.clear();
    await GoogleSignIn().signOut();
    await api.AuthRequests.logout();
    user = null;
    player = null;
  }

  /// Send the FCM token to server, only works on `Android`
  void sendFcmToken(String fcmToken) async {
    // send the fcm token of the devivce to the server
    // for sending notification fcm token is used only
    // for the server, and not stored on the app/ browser

    api.AuthRequests.fcmToken(fcmToken: fcmToken);
  }

  /// Claim a player profile and connect it to the user
  Future<bool> claimPlayer(String otp, String playerId) async {
    // Sends an otp and playerId to server to check
    // if a loadout exists with that OTP
    // if it does, then player is verified

    final verification = utilities.RSACrypto.encryptRSA(otp);

    final response = await api.AuthRequests.claimPlayer(
      verification: verification,
      playerId: playerId,
    );
    if (response == null) {
      return false;
    }

    if (response.verified) {
      // if verified, then save the user and player in the provider

      user = response.user;
      player = response.player;
      utilities.Database.saveUser(user!);
      utilities.Database.savePlayer(player!);
    }

    return response.verified;
  }

  /// Marks, unmarks a `friend` player as favourite
  Future<int> markFavouriteFriend(String playerId) async {
    // returns 0,1 or 2 as response
    // 0 -> player is removed from favouriteFriends
    // 1 -> player is added in favouriteFriends
    // 2 -> player is not added due to favouriteFriends limit reached

    if (user == null) return 0;

    final favouriteFriendsClone = List<String>.from(user!.favouriteFriends);

    if (!user!.favouriteFriends.contains(playerId)) {
      // player is not in the favouriteFriends, so we need to add him

      // check if user already has max number of friends
      if (user!.favouriteFriends.length >=
          utilities.Global.essentials!.maxFavouriteFriends) {
        return 2;
      }

      user!.favouriteFriends.add(playerId);
    } else {
      // if he is in the favouriteFriends, then remove him
      user!.favouriteFriends.remove(playerId);
    }

    notifyListeners();

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

    notifyListeners();

    return 1;
  }

  /// Toggle the theme from `light` to `dark` and vice versa
  void toggleTheme(ThemeMode themeMode) {
    settings.themeMode = themeMode;

    // save the settings after changing the theme
    utilities.Database.saveSettings(settings);
    notifyListeners();
  }
}

/// Provider to handle auth and user data
final auth = ChangeNotifierProvider((_) => _AuthNotifier());
