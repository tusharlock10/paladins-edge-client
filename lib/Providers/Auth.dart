import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Models/index.dart' as Models;
import '../Utilities/index.dart' as Utilities;
import '../Constants.dart' as Constants;

class Auth with ChangeNotifier {
  Models.User? user;

  Future<bool> login() async {
    this.user = Utilities.Database.getUser();

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

    this.user = Models.User.fromJson(response.data);
    Utilities.Database.setUser(this.user!);
    Utilities.api.options.headers["authorization"] = this.user!.token;
    return true;
  }
}
