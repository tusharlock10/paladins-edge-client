import "package:flutter/material.dart";
import "package:flutter_native_splash/flutter_native_splash.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_web_plugins/url_strategy.dart";
import "package:overlay_support/overlay_support.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/router/index.dart" as router;
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;
import "package:responsive_framework/responsive_framework.dart";

Future<void> init() async {
  utilities.Stopwatch.startStopTimer("appInitialization");

  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // remove the splash screen regardless after 2 seconds
  Future.delayed(const Duration(seconds: 3)).then(
    (value) => FlutterNativeSplash.remove(),
  );

  // init basic services
  await Future.wait([
    utilities.initFirebaseApp(),
    utilities.Database.initialize(),
    utilities.Global.initPaladinsAssets(),
    utilities.setDeviceOrientation(),
    utilities.setHighRefreshRate(),
    utilities.initPackageInfo(),
  ]);

  // init firebase services
  await Future.wait([
    utilities.Analytics.initialize(),
    utilities.RealtimeGlobalChat.initialize(),
    utilities.RemoteConfig.initialize(),
  ]);

  usePathUrlStrategy();
  utilities.Stopwatch.startStopTimer("appInitialization");
}

void main() async {
  await init();
  runApp(const ProviderScope(child: PaladinsEdgeApp()));
}

class PaladinsEdgeApp extends ConsumerWidget {
  const PaladinsEdgeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final themeMode = ref.watch(
      providers.appState.select((_) => _.settings.themeMode),
    );

    return OverlaySupport.global(
      toastTheme: ToastThemeData(alignment: Alignment.bottomCenter),
      child: GestureDetector(
        onTap: () => utilities.unFocusKeyboard(context),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: theme.lightTheme,
          darkTheme: theme.darkTheme,
          routeInformationProvider: router.router.routeInformationProvider,
          routeInformationParser: router.router.routeInformationParser,
          routerDelegate: router.router.routerDelegate,
          title: "Paladins Edge",
          color: Colors.white,
          scrollBehavior: BouncingScrollBehavior(),
          builder: (context, widget) => ResponsiveBreakpoints.builder(
            child: widgets.ScreenInitialization(
              screen: widget,
            ),
            breakpoints: [
              const Breakpoint(
                start: constants.ResponsiveBreakpoints.mobile,
                end: constants.ResponsiveBreakpoints.tablet,
                name: MOBILE,
              ),
              const Breakpoint(
                start: constants.ResponsiveBreakpoints.tablet,
                end: constants.ResponsiveBreakpoints.desktop,
                name: TABLET,
              ),
              const Breakpoint(
                start: constants.ResponsiveBreakpoints.desktop,
                end: double.infinity,
                name: DESKTOP,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
