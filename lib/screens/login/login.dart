import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/screens/login/login_landscape.dart';
import 'package:paladinsedge/screens/login/login_portrait.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class Login extends HookConsumerWidget {
  static const routeName = '/';

  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final authProvider = ref.read(providers.auth);

    // Variables
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    // State
    final isLoggingIn = useState(false);
    final isCheckingLogin = useState(true);
    final isInitialized = useState(false);

    // Methods
    final checkLogin = useCallback(
      () async {
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
          isCheckingLogin.value = false;
        }
      },
      [],
    );

    final initApp = useCallback(
      () async {
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

        await utilities.RSACrypto.setupRSAPublicKey();
        await utilities.Database.initDatabase();
        await FirebasePerformance.instance
            .setPerformanceCollectionEnabled(!constants.isDebug);
        await FirebaseAnalytics.instance
            .setAnalyticsCollectionEnabled(!constants.isDebug);

        authProvider.loadEssentials(); // load the essentials from hive
        authProvider.loadSettings(); // load the settings from hive

        isInitialized.value = true;

        checkLogin();
      },
      [],
    );

    final onGoogleSignIn = useCallback(
      () async {
        if (isLoggingIn.value) {
          return;
        }

        final authProvider = ref.read(providers.auth);

        isLoggingIn.value = true;

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
          isLoggingIn.value = false;
        }
      },
      [],
    );

    // Effects
    useEffect(
      () {
        initApp();

        return null;
      },
      [],
    );

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
        child: (isCheckingLogin.value || !isInitialized.value)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const widgets.LoadingIndicator(
                    size: 36,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    isCheckingLogin.value ? 'Please Wait' : 'Initializing',
                    style: textTheme.bodyText1?.copyWith(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              )
            : height > width
                ? LoginPortrait(
                    isLoggingIn: isLoggingIn.value,
                    onGoogleSignIn: onGoogleSignIn,
                  )
                : LoginLandscape(
                    isLoggingIn: isLoggingIn.value,
                    onGoogleSignIn: onGoogleSignIn,
                  ),
      ),
    );
  }
}
