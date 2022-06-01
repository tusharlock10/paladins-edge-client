import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:overlay_support/overlay_support.dart";
import "package:paladinsedge/constants.dart" as constants;
import "package:paladinsedge/firebase_options.dart" as firebase_options;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/router/index.dart" as router;
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;
import "package:responsive_framework/responsive_framework.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    if (!constants.isDebug)
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]),
    Firebase.initializeApp(
      name: constants.isWeb ? null : "root",
      options: firebase_options.DefaultFirebaseOptions.currentPlatform,
    ),
  ]);

  utilities.Messaging.onMessage();
  utilities.Messaging.onBackgroundMessage();
  utilities.Messaging.registerLocalNotification();

  runApp(const ProviderScope(child: PaladinsEdgeApp()));
}

class PaladinsEdgeApp extends ConsumerWidget {
  const PaladinsEdgeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final themeMode = ref.watch(
      providers.auth.select((_) => _.settings.themeMode),
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
          routeInformationParser: router.router.routeInformationParser,
          routerDelegate: router.router.routerDelegate,
          title: "Paladins Edge",
          color: Colors.white,
          scrollBehavior: BouncingScrollBehavior(),
          builder: (context, widget) => ResponsiveWrapper.builder(
            widgets.ScreenInitialization(
              screen: widget,
            ),
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(
                constants.ResponsiveBreakpoints.mobile,
                name: MOBILE,
              ),
              const ResponsiveBreakpoint.autoScale(
                constants.ResponsiveBreakpoints.tablet,
                name: TABLET,
              ),
              const ResponsiveBreakpoint.resize(
                constants.ResponsiveBreakpoints.desktop,
                name: DESKTOP,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
