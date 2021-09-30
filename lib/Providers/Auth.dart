import 'dart:convert';

import 'package:crypto/crypto.dart' as Crypto;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Api/index.dart' as Api;
import '../Constants.dart' as Constants;
import '../Models/index.dart' as Models;
import '../Utilities/index.dart' as Utilities;

// handles auth and user data
class Auth with ChangeNotifier {
  Models.User? user;
  Models.Player? player;
  Models.Settings settings = Models.Settings();

  void loadSettings() {
    final settings = Utilities.Database.getSettings();

    if (settings != null) {
      // if settings are present, then replace the newly create settings with user's settings
      this.settings = settings;
    }
    notifyListeners();
  }

  Future<bool> login() async {
    this.user = Utilities.Database.getUser();
    this.player = Utilities.Database.getPlayer();

    if (this.user != null) {
      Utilities.api.options.headers["authorization"] = this.user!.token;
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

    final response = await Api.AuthRequests.login({
      'name': firebaseUser.user?.displayName,
      'email': firebaseUser.user?.email,
      'photoUrl': firebaseUser.user?.photoURL,
      'uid': firebaseUser.user?.uid,
    });
    // user will have token
    // If player is null, navigate to ConnectProfile

    this.user = response.user;
    Utilities.Database.setUser(this.user!);
    if (response.player != null) {
      this.player = response.player;
      Utilities.Database.setPlayer(this.player!);
    }

    Utilities.api.options.headers["authorization"] = this.user!.token;
    return true;
  }

  Future<void> logout() async {
    // 1) Clear user's storage first so,
    //    if the logout fails in the steps below
    //    he can still login
    // 2) Signout from google
    // 3) Notify backend about logout
    // 4) remove user from provider

    Utilities.Database.clear();
    await GoogleSignIn().signOut();
    await Utilities.api.post(Constants.Urls.logout);
    this.user = null;
  }

  void sendFcmToken(String fcmToken) async {
    // send the fcm token of the devivce to the server
    // for sending notification fcm token is use only
    // for the server, and not stored on the app/ browser

    Utilities.api.post(Constants.Urls.fcmToken, data: {'fcmToken': fcmToken});
  }

  Future<bool> claimPlayer(String otp, String playerId) async {
    // Sends an otp and playerId to server to check if a loadout exists with that otp
    // if it does, then player is verified
    //
    final otpHash =
        Crypto.sha1.convert(utf8.encode('${Constants.OtpSalt}$otp')).toString();

    final response = await Utilities.api.post(Constants.Urls.claimPlayer,
        data: {
          'otpHash': otpHash,
          'playerId': playerId
        }); // response.data = {verified:bool, user:User, player:Player}
    if (response.data['verified']) {
      // if verified, then save the user and player in the provider

      response.data['user']['token'] = this.user!.token;
      this.user = Models.User.fromJson(response.data['user']);
      this.player = Models.Player.fromJson(response.data['player']);
      Utilities.Database.setUser(this.user!);
      Utilities.Database.setPlayer(this.player!);
    }

    return response.data['verified'];
  }

  Future<void> observePlayer(String playerId) async {
    if (this.user == null) return;

    if (this.user!.observeList.contains(playerId) == false)
      // player is not in the observe list, so we need to add him
      this.user!.observeList.add(playerId);
    else
      // if he is in the observe list, then remove him
      this.user!.observeList.remove(playerId);

    notifyListeners();

    // after we update the UI, update the list in backend
    // update the UI for the latest changes

    final response = await Utilities.api
        .post(Constants.Urls.observePlayer, data: {'playerId': playerId});
    this.user!.observeList = List<String>.from(response.data['observeList']);
    notifyListeners();
  }

  void toggleTheme() {
    // toggles the theme
    if (this.settings.themeMode == ThemeMode.dark) {
      this.settings.themeMode = ThemeMode.light;
    } else {
      this.settings.themeMode = ThemeMode.dark;
    }

    // save the settings after changing the theme
    Utilities.Database.setSettings(this.settings);
    notifyListeners();
  }
}
