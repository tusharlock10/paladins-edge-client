import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paladinsedge/app_theme.dart' as app_theme;
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const routeName = '/';
  const Login({Key? key}) : super(key: key);

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
    if (_init) {
      _init = false;
      initApp();
    }
    super.didChangeDependencies();
  }

  Future<void> initApp() async {
    // first initialize all env variables and check
    // if all the env variables are loaded properly
    final missingEnvs = await constants.Env.loadEnv();
    if (missingEnvs.isNotEmpty) {
      // if some variables are missing then open up an alert
      // and do not let the app proceed forward
      WidgetsBinding.instance?.addPostFrameCallback(
        (_) => widgets.showDebugAlert(
          context: context,
          isDismissable: false,
          message: 'Env variable ${missingEnvs.join(", ")} not found',
          forceShow: true,
        ),
      );
      return;
    }

    await utilities.Database.initDatabase();
    await FirebasePerformance.instance
        .setPerformanceCollectionEnabled(!constants.isDebug);
    await FirebaseAnalytics.instance
        .setAnalyticsCollectionEnabled(!constants.isDebug);

    setState(() => _isInitialized = true);

    final authProvider = Provider.of<providers.Auth>(context, listen: false);

    authProvider.loadEssentials(); // load the essentials from hive
    authProvider.loadSettings(); // load the settings from hive

    final loggedIn = await authProvider.login();

    if (loggedIn) {
      // after the user is logged in, send the device fcm token to the server
      final fcmToken = await utilities.Messaging.initMessaging();
      if (fcmToken != null) authProvider.sendFcmToken(fcmToken);

      Navigator.pushReplacementNamed(
        context,
        authProvider.user?.playerId == null
            ? screens.ConnectProfile.routeName
            : screens.BottomTabs.routeName,
      );
    } else {
      setState(() {
        _isCheckingLogin = false;
        _init = false;
      });
    }
  }

  void onGoogleSignIn(BuildContext context) async {
    if (_isLoggingIn) {
      return;
    }

    final authProvider = Provider.of<providers.Auth>(context, listen: false);

    setState(() => _isLoggingIn = true);
    final loginSuccess = await authProvider.signInWithGoogle();
    if (loginSuccess) {
      // after the user is logged in, send the device fcm token to the server
      final fcmToken = await utilities.Messaging.initMessaging();
      if (fcmToken != null) authProvider.sendFcmToken(fcmToken);

      Navigator.pushReplacementNamed(
        context,
        authProvider.user?.playerId == null
            ? screens.ConnectProfile.routeName
            : screens.BottomTabs.routeName,
      );
    } else {
      setState(() => _isLoggingIn = false);
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
      padding: const EdgeInsets.only(right: 15),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
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
            onTap: () => widgets.showInfoAlert(context),
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
    return widgets.Ripple(
      margin: const EdgeInsets.only(bottom: 25, left: 15, right: 15),
      width: width - 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF202020).withOpacity(0.25),
            blurRadius: 5,
            offset: const Offset(0, 5),
          )
        ],
      ),
      borderRadius: BorderRadius.circular(15),
      onTap: () => onGoogleSignIn(context),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        children: [
          _isLoggingIn
              ? const widgets.LoadingIndicator(
                  lineWidth: 3,
                  size: 36,
                  color: app_theme.themeMaterialColor,
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
    if (_isCheckingLogin || !_isInitialized) {
      return const Center(
        child: SpinKitRing(
          lineWidth: 4,
          color: Colors.white,
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildBigIcon(context),
        buildTageLine(context),
        buildGoogleButton(context),
      ],
    );
  }

  Widget buildLoginLandscape(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: buildBigIcon(context),
        ),
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildTageLine(context),
              buildGoogleButton(context),
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6DD5ED),
              Color(0xFF2193B0),
            ],
          ),
        ),
        child:
            height > width ? buildLogin(context) : buildLoginLandscape(context),
      ),
    );
  }
}
