import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './index.dart' as Screens;
import '../AppTheme.dart' as AppTheme;
import '../Constants.dart' as Constants;
import '../Providers/index.dart' as Providers;
import '../Utilities/index.dart' as Utilities;
import '../Widgets/index.dart' as Widgets;

class Login extends StatefulWidget {
  static const routeName = '/';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
    await Utilities.Database.initDatabase();
    await Firebase.initializeApp();
    await FirebasePerformance.instance
        .setPerformanceCollectionEnabled(!Constants.IsDebug);
    await FirebaseAnalytics().setAnalyticsCollectionEnabled(!Constants.IsDebug);

    this.setState(() => this._isInitialized = true);

    final authProvider = Provider.of<Providers.Auth>(context, listen: false);
    final loggedIn = await authProvider.login();

    authProvider.loadSettings(); // load the settings from hive

    if (loggedIn) {
      // after the user is logged in, send the device fcm token to the server
      final fcmToken = await Utilities.Messaging.initMessaging();
      if (fcmToken != null) authProvider.sendFcmToken(fcmToken);

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
      // after the user is logged in, send the device fcm token to the server
      final fcmToken = await Utilities.Messaging.initMessaging();
      if (fcmToken != null) authProvider.sendFcmToken(fcmToken);

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

  void showInfoAlert(BuildContext context) {
    showDialog(context: context, builder: (_) => Widgets.InfoAlert());
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
          GestureDetector(
            onTap: () => this.showInfoAlert(context),
            child: Container(
              transform: Matrix4.translationValues(25, 0, 0)..rotateZ(-0.12),
              child: Image.asset(
                'assets/icons/paladins.png',
                width: 140,
              ),
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
        ],
      ),
      borderRadius: BorderRadius.circular(15),
      onTap: () => this.onGoogleSignIn(context),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        children: [
          this._isLoggingIn
              ? Widgets.LoadingIndicator(
                  lineWidth: 3,
                  size: 36,
                  color: AppTheme.ThemeMaterialColor,
                )
              : Image.asset(
                  'assets/icons/google-colored.png',
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
