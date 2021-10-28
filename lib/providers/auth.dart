import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;

// handles auth and user data
class Auth with ChangeNotifier {
  models.User? user;
  models.Player? player;
  models.Settings settings = models.Settings();

  void loadSettings() {
    final settings = utilities.Database.getSettings();

    if (settings != null) {
      // if settings are present, then replace the newly create settings with user's settings
      this.settings = settings;
    }
    notifyListeners();
  }

  Future<bool> login() async {
    user = utilities.Database.getUser();
    player = utilities.Database.getPlayer();

    if (user != null) {
      utilities.api.options.headers["authorization"] = user!.token;
      return true;
    } else {
      return false;
    }
  }

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

    if (firebaseUser.user == null) {
      return false;
    }

    final response = await api.AuthRequests.login(
      uid: firebaseUser.user!.uid,
      email: firebaseUser.user!.email,
      name: firebaseUser.user!.displayName,
      photoUrl: firebaseUser.user!.photoURL,
    );
    // user will have token
    // If player is null, navigate to ConnectProfile

    if (response == null) return false;

    user = response.user;
    utilities.Database.setUser(response.user);
    if (response.player != null) {
      player = response.player;
      utilities.Database.setPlayer(response.player!);
    }

    utilities.api.options.headers["authorization"] = user!.token;
    return true;
  }

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

  void sendFcmToken(String fcmToken) async {
    // send the fcm token of the devivce to the server
    // for sending notification fcm token is use only
    // for the server, and not stored on the app/ browser

    api.AuthRequests.fcmToken(fcmToken: fcmToken);
  }

  Future<bool> claimPlayer(String otp, String playerId) async {
    // Sends an otp and playerId to server to check if a loadout exists with that otp
    // if it does, then player is verified
    //
    final otpHash = crypto.sha1
        .convert(utf8.encode('${constants.Env.otpSalt}$otp'))
        .toString();

    final response = await api.AuthRequests.claimPlayer(
        otpHash: otpHash, playerId: playerId);
    if (response == null) {
      return false;
    }

    if (response.verified) {
      // if verified, then save the user and player in the provider

      user = response.user;
      player = response.player;
      utilities.Database.setUser(user!);
      utilities.Database.setPlayer(player!);
    }

    return response.verified;
  }

  Future<bool> observePlayer(String playerId) async {
    // return true if a new playerId is added in observeList else false
    bool newPlayedAdded = false;
    if (user == null) {
      return newPlayedAdded;
    }

    final observeListClone = List<String>.from(user!.observeList);

    if (user!.observeList.contains(playerId) == false) {
      // player is not in the observe list, so we need to add him
      user!.observeList.add(playerId);
      newPlayedAdded = true;
    } else {
      // if he is in the observe list, then remove him
      user!.observeList.remove(playerId);
    }

    notifyListeners();

    // after we update the UI, update the list in backend
    // update the UI for the latest changes

    final response = await api.AuthRequests.observePlayer(playerId: playerId);
    if (response == null) {
      // if the response fails for some reason, revert back the change
      // set newPlayerAdded to false
      user!.observeList = observeListClone;
      newPlayedAdded = false;
    } else {
      user!.observeList = response.observeList;
    }

    notifyListeners();
    return newPlayedAdded;
  }

  Future<bool> favouriteFriend(String playerId) async {
    // return true if a new playerId is added in favouriteFriends else false
    bool newPlayedAdded = false;
    if (user == null) return newPlayedAdded;

    final favouriteFriendsClone = List<String>.from(user!.favouriteFriends);

    if (user!.favouriteFriends.contains(playerId) == false) {
      // player is not in the favouriteFriends, so we need to add him
      user!.favouriteFriends.add(playerId);
      newPlayedAdded = true;
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
      newPlayedAdded = false;
    } else {
      user!.favouriteFriends = response.favouriteFriends;
    }

    notifyListeners();
    return newPlayedAdded;
  }

  void toggleTheme() {
    // toggles the theme
    if (settings.themeMode == ThemeMode.dark) {
      settings.themeMode = ThemeMode.light;
    } else {
      settings.themeMode = ThemeMode.dark;
    }

    // save the settings after changing the theme
    utilities.Database.setSettings(settings);
    notifyListeners();
  }
}
