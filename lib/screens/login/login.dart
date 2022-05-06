import 'package:beamer/beamer.dart';
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
        final loggedIn = await authProvider.checkLogin();

        if (loggedIn) {
          // after the user is logged in, send the device fcm token to the server
          final fcmToken = await utilities.Messaging.initMessaging();
          if (fcmToken != null) authProvider.sendFcmToken(fcmToken);

          context.beamToReplacementNamed(
            authProvider.user?.playerId == null
                ? screens.ConnectProfile.routeName
                : screens.Main.routeName,
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
              isDismissible: false,
              message: 'Env variable ${missingEnvs.join(", ")} not found',
              forceShow: true,
            ),
          );

          return;
        }

        await Future.wait([
          utilities.RSACrypto.setupRSAPublicKey(),
          utilities.Database.initDatabase(),
          utilities.RemoteConfig.setupRemoteConfig(),
          FirebasePerformance.instance
              .setPerformanceCollectionEnabled(!constants.isDebug),
          FirebaseAnalytics.instance
              .setAnalyticsCollectionEnabled(!constants.isDebug),
        ]);

        // load the essentials from hive
        // this depends on initDatabase to be completed
        await authProvider.loadEssentials();
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

        isLoggingIn.value = true;

        final response = await authProvider.signInWithGoogle();
        if (response.result) {
          // after the user is logged in, send the device fcm token to the server
          final fcmToken = await utilities.Messaging.initMessaging();
          if (fcmToken != null) authProvider.sendFcmToken(fcmToken);

          context.beamToReplacementNamed(
            authProvider.user?.playerId == null
                ? screens.ConnectProfile.routeName
                : screens.Main.routeName,
          );
        } else {
          isLoggingIn.value = false;
          if (response.errorCode != null && response.errorMessage != null) {
            widgets.showToast(
              context: context,
              text: response.errorMessage!,
              type: widgets.ToastType.error,
              errorCode: response.errorCode,
            );
          }
        }
      },
      [],
    );

    final onGuestLogin = useCallback(
      () {
        authProvider.loginAsGuest();
        context.beamToReplacementNamed(screens.Main.routeName);
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
                    lineWidth: 2,
                    size: 28,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Please Wait',
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
                    onGuestLogin: onGuestLogin,
                  )
                : LoginLandscape(
                    isLoggingIn: isLoggingIn.value,
                    onGoogleSignIn: onGoogleSignIn,
                    onGuestLogin: onGuestLogin,
                  ),
      ),
    );
  }
}
