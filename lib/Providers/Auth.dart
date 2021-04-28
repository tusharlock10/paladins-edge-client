import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto/crypto.dart' as Crypto;

import '../Models/index.dart' as Models;
import '../Utilities/index.dart' as Utilities;
import '../Constants.dart' as Constants;

class Auth with ChangeNotifier {
  Models.User? user;
  Models.Player? player;

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

    final response = await Utilities.api.post(Constants.Urls.login, data: {
      'name': firebaseUser.user?.displayName,
      'email': firebaseUser.user?.email,
      'photoUrl': firebaseUser.user?.photoURL,
      'uid': firebaseUser.user?.uid,
    });
    // response = {user, player}
    // user will have token
    // If player is null, navigate to ConnectProfile

    this.user = Models.User.fromJson(response.data['user']);
    Utilities.Database.setUser(this.user!);
    if (response.data['player'] != null) {
      this.player = Models.Player.fromJson(response.data['player']);
      Utilities.Database.setPlyer(this.player!);
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

  Future<bool> claimPlayer(String otp, int playerId) async {
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
      Utilities.Database.setPlyer(this.player!);
    }

    return response.data['verified'];
  }
}
