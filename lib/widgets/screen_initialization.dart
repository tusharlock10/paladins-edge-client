import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;
import "package:pub_semver/pub_semver.dart";

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
    final appStateProvider = ref.read(providers.appState);
    final itemsProvider = ref.read(providers.items);
    final baseRanksProvider = ref.read(providers.baseRanks);
    final isInitialized = ref.watch(
      providers.auth.select((_) => _.isInitialized),
    );
    final isForceUpdatePending = ref.watch(
      providers.auth.select((_) => _.isForceUpdatePending),
    );

    // Variables
    final textTheme = Theme.of(context).textTheme;

    // Methods
    final initApp = useCallback(
      () async {
        final result = await Future.wait([
          utilities.RemoteConfig.initialize(),
          PackageInfo.fromPlatform(),
        ]);
        final packageInfo = result.last as PackageInfo;

        final currentVersion = Version.parse(packageInfo.version);
        if (currentVersion < utilities.RemoteConfig.lowestSupportedVersion) {
          return authProvider.setForceUpdatePending();
        }

        await utilities.Database.initialize();
        appStateProvider.loadSettings();
        authProvider.loadPaladinsAssets();

        // first initialize all env variables and check
        // if all the env variables are loaded properly
        final missingEnvs = await constants.Env.loadEnv();
        if (missingEnvs.isNotEmpty) {
          // if some variables are missing then open up an alert
          // and do not let the app proceed forward
          utilities.postFrameCallback(
            () => widgets.showDebugAlert(
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
          utilities.RealtimeGlobalChat.initialize(),
          utilities.Analytics.initialize(),
          utilities.RealtimeGlobalChat.initialize(),
          authProvider.loadEssentials(),
          itemsProvider.loadItems(),
          baseRanksProvider.loadBaseRanks(),
        ]);

        // load the essentials from hive
        // this depends on initDatabase to be completed
        authProvider.checkLogin();
        authProvider.getApiStatus();
        authProvider.setAppInitialized();

        utilities.Analytics.logEvent(constants.AnalyticsEvent.appInitialized);
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

    return isInitialized && screen != null
        ? screen!
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
                isForceUpdatePending
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              Text(
                                "Pending update",
                                style: textTheme.displayLarge?.copyWith(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Unfortunately this new update brings some breaking changes due to which you are required to update",
                                textAlign: TextAlign.center,
                                style: textTheme.bodyLarge?.copyWith(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.85),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : widgets.LoadingIndicator(
                        lineWidth: 2,
                        size: 28,
                        color: Colors.white,
                        label: Text(
                          "Please Wait",
                          style: textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ),
              ],
            ),
          );
  }
}
