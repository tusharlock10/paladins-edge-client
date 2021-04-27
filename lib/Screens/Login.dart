import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import './index.dart' as Screens;
import '../Providers/index.dart' as Providers;
import '../Constants.dart' as Constants;
import '../Widgets/index.dart' as Widgets;
import '../Utilities/index.dart' as Utilities;

class Login extends StatefulWidget {
  static const routeName = '/';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Future<FirebaseApp> _initFirebase = Firebase.initializeApp();
  final Future<void> _initDatabase = Utilities.Database.initDatabase();
  bool _isLoggingIn = false;
  bool _isCheckingLogin = true;
  bool _isInitialized = false;
  bool _init = true;

  @override
  void didChangeDependencies() {
    if (this._init) {
      this._init = false;
      this.initApp();
    }
    super.didChangeDependencies();
  }

  Future<void> initApp() async {
    await Future.wait([this._initDatabase, this._initFirebase]);
    this.setState(() => this._isInitialized = true);

    final authProvider = Provider.of<Providers.Auth>(context, listen: false);
    final loggedIn = await authProvider.login();

    if (loggedIn) {
      Navigator.pushReplacementNamed(
        context,
        authProvider.user?.playerId == null
            ? Screens.ConnectProfile.routeName
            : Screens.BottomTabs.routeName,
      );
    } else {
      this.setState(() {
        this._isCheckingLogin = false;
        this._init = false;
      });
    }
  }

  void onGoogleSignIn(context) async {
    if (this._isLoggingIn) {
      return;
    }
    final authProvider = Provider.of<Providers.Auth>(context, listen: false);

    this.setState(() => this._isLoggingIn = true);
    final loginSuccess = await authProvider.signInWithGoogle();
    if (loginSuccess) {
      Navigator.pushReplacementNamed(
        context,
        authProvider.user?.playerId == null
            ? Screens.ConnectProfile.routeName
            : Screens.BottomTabs.routeName,
      );
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
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15),
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
          ),
          Container(
            transform: Matrix4.translationValues(25, 0, 0)..rotateZ(-0.12),
            child: Image.asset(
              'assets/icons/paladins.png',
              width: 140,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGoogleButton(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Widgets.Ripple(
      margin: EdgeInsets.only(bottom: 25, left: 15, right: 15),
      width: width - 30,
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
      borderRadius: BorderRadius.circular(15),
      onTap: () => this.onGoogleSignIn(context),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        children: [
          this._isLoggingIn
              ? SpinKitRing(
                  lineWidth: 3,
                  size: 36,
                  color: Constants.ThemeMaterialColor,
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
    );
  }

  Widget buildLogin(BuildContext context) {
    if (this._isCheckingLogin || !this._isInitialized) {
      return Center(
        child: SpinKitRing(
          lineWidth: 4,
          color: Colors.white,
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        this.buildBigIcon(context),
        this.buildTageLine(context),
        this.buildGoogleButton(context),
      ],
    );
  }

  Widget buildLoginLandscape(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: this.buildBigIcon(context),
        ),
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              this.buildTageLine(context),
              this.buildGoogleButton(context),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xFF6DD5ED),
              Color(0xFF2193B0),
            ])),
        child: height > width
            ? this.buildLogin(context)
            : this.buildLoginLandscape(context),
      ),
    );
  }
}
