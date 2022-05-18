import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

/// Screen initialization widget
/// Wrap a screen with this widget
///
/// used to ensure app is in functioning state
/// before user an access any screen
///
/// To be used on all screens to check if app initialized
///
/// It does 2 things -
/// 1) Setup essentials and envs
/// 2) Logs in user is token is present in local db
class ScreenInitialization extends HookConsumerWidget {
  final Widget? screen;
  const ScreenInitialization({
    required this.screen,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final authProvider = ref.read(providers.auth);
    final isInitialized = ref.watch(
      providers.auth.select((_) => _.isInitialized),
    );

    // Variables
    final textTheme = Theme.of(context).textTheme;

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
          utilities.RSACrypto.initialize(),
          utilities.Database.initialize(),
          utilities.RemoteConfig.initialize(),
          FirebasePerformance.instance.setPerformanceCollectionEnabled(
            !constants.isDebug,
          ),
          FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(
            !constants.isDebug,
          ),
        ]);
        utilities.RealtimeGlobalChat.initialize();

        // load the essentials from hive
        // this depends on initDatabase to be completed
        await authProvider.loadEssentials();
        authProvider.loadSettings(); // load the settings from hive
        authProvider.checkLogin();
        authProvider.setAppInitialized();
      },
      [],
    );

    // Effects
    useEffect(
      () {
        if (!isInitialized) initApp();

        return null;
      },
      [isInitialized],
    );

    return isInitialized
        ? screen ?? const SizedBox()
        : DecoratedBox(
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
            child: Column(
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
            ),
          );
  }
}
