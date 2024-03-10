import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/loading_indicator.dart";
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
/// 1) Setup essentials
/// 2) Logs in user if token is present in local db
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
    final lightTextTheme = theme.lightTheme.textTheme;
    const loginHelpText = constants.isWeb
        ? constants.loginHelpTextWeb
        : constants.loginHelpTextMobile;
    const loginHelpTitle =
        "Loading issues on ${constants.isWeb ? 'Web' : 'Mobile'}";

    // Hooks
    final showLoadingFAQ = useState(false);
    final showLoadingHelp = useState(false);

    // Methods
    final initApp = useCallback(
      () async {
        utilities.Stopwatch.startStopTimer("screenInitialization");

        authProvider.loadPaladinsAssets();

        await utilities.Database.initialize();
        appStateProvider.loadSettings();

        utilities.initializeApi();
        await Future.wait([
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
        utilities.Stopwatch.startStopTimer("screenInitialization");
      },
      [],
    );

    final checkForceUpdate = useCallback(
      () async {
        final result = await Future.wait([
          utilities.RemoteConfig.initialize(),
          PackageInfo.fromPlatform(),
        ]);
        final packageInfo = result.last as PackageInfo;

        final currentVersion = Version.parse(packageInfo.version);
        if (currentVersion < utilities.RemoteConfig.lowestSupportedVersion) {
          authProvider.setForceUpdatePending();
        }
      },
      [],
    );

    final onLoadingHelp = useCallback(
      () {
        showLoadingHelp.value = !showLoadingHelp.value;
      },
      [showLoadingHelp],
    );

    // Effects
    useEffect(
      () {
        checkForceUpdate();
        initApp();

        return null;
      },
      [],
    );

    useEffect(
      () {
        Future.delayed(const Duration(seconds: 7)).then(
          (value) => showLoadingFAQ.value = true,
        );

        return null;
      },
      [],
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
              mainAxisAlignment: isForceUpdatePending
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                if (isForceUpdatePending)
                  Center(
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
                  ),
                if (!isForceUpdatePending) ...[
                  const SizedBox(height: 60),
                  LoadingIndicator(
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
                  if (showLoadingHelp.value)
                    Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      elevation: 15,
                      shadowColor:
                          theme.lightTheme.shadowColor.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Column(
                          children: [
                            Text(
                              loginHelpTitle,
                              style: lightTextTheme.displayLarge
                                  ?.copyWith(fontSize: 20),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              loginHelpText,
                              style: lightTextTheme.bodyLarge
                                  ?.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      onTap: showLoadingFAQ.value ? onLoadingHelp : null,
                      child: SizedBox(
                        height: 50,
                        child: Center(
                          child: AnimatedOpacity(
                            opacity: showLoadingFAQ.value ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            child: Text(
                              "Stuck on loading?",
                              textAlign: TextAlign.center,
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
  }
}
