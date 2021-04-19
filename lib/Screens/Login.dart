import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import './index.dart' as Screens;
import '../Providers/index.dart' as Providers;
import '../Constants.dart' as Constants;

class Login extends StatefulWidget {
  static const routeName = '/';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  bool _isLoggingIn = false;
  bool _isCheckingLogin = true;
  bool _init = true;

  @override
  void didChangeDependencies() {
    if (this._init) {
      Provider.of<Providers.Auth>(context).login().then((loggedIn) {
        if (loggedIn) {
          Navigator.pushReplacementNamed(context, Screens.BottomTabs.routeName);
        } else {
          this.setState(() {
            this._isCheckingLogin = false;
            this._init = false;
          });
        }
      });
    }
    super.didChangeDependencies();
  }

  void onGoogleSignIn(context) async {
    if (this._isLoggingIn) {
      return;
    }
    this.setState(() => this._isLoggingIn = true);
    final loginSuccess =
        await Provider.of<Providers.Auth>(context, listen: false)
            .signInWithGoogle();
    if (loginSuccess) {
      Navigator.pushReplacementNamed(context, Screens.BottomTabs.routeName);
    } else {
      this.setState(() => this._isLoggingIn = false);
    }
  }

  Widget buildBigIcon(BuildContext context) {
    return Container(
      transform: Matrix4.translationValues(0, -50.0, 0.0),
      child: Image.asset(
        'assets/icons/icon.png',
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget buildTageLine(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 15),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            transform: Matrix4.translationValues(-10, 0, 0)..rotateZ(0.12),
            child: Image.asset(
              'assets/icons/paladins.png',
              width: 140,
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                'Feature rich\nPaladins manager',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGoogleButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF202020).withOpacity(0.25),
              blurRadius: 5,
              offset: Offset(0, 5),
            )
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          child: InkWell(
            onTap: () => this.onGoogleSignIn(context),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                children: [
                  this._isLoggingIn
                      ? SpinKitRing(
                          lineWidth: 3,
                          size: 36,
                          color: Constants.themeMaterialColor,
                        )
                      : Image.asset(
                          'assets/icons/google.png',
                          width: 36,
                          height: 36,
                        ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'SignIn with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade800,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLogin(BuildContext context) {
    if (this._isCheckingLogin) {
      return Center(
        child: SpinKitRing(
          lineWidth: 4,
          color: Colors.white,
        ),
      );
    }
    return FutureBuilder(
      future: this._initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              this.buildBigIcon(context),
              this.buildTageLine(context),
              this.buildGoogleButton(context),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xFF6DD5ED),
              Color(0xFF2193B0),
            ])),
        child: this.buildLogin(context),
      ),
    );
  }
}
