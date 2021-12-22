import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/screens/login/login_landscape.dart';
import 'package:paladinsedge/screens/login/login_portrait.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class Login extends ConsumerStatefulWidget {
  static const routeName = '/';
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
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

    final authProvider = ref.read(providers.auth);

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

  void onGoogleSignIn() async {
    if (_isLoggingIn) {
      return;
    }

    final authProvider = ref.read(providers.auth);

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
        child: height > width
            ? LoginPortrait(
                isInitialized: _isInitialized,
                isCheckingLogin: _isCheckingLogin,
                isLoggingIn: _isLoggingIn,
                onGoogleSignIn: onGoogleSignIn,
              )
            : LoginLandscape(
                isInitialized: _isInitialized,
                isCheckingLogin: _isCheckingLogin,
                isLoggingIn: _isLoggingIn,
                onGoogleSignIn: onGoogleSignIn,
              ),
      ),
    );
  }
}
