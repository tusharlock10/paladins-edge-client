import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:paladinsedge/app_theme.dart' as app_theme;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/utilities/messaging.dart' as messaging;
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  messaging.Messaging.onMessage();
  messaging.Messaging.onBackgroundMessage();
  messaging.Messaging.registerLocalNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      toastTheme: ToastThemeData(alignment: Alignment.bottomCenter),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => providers.Auth()),
          ChangeNotifierProvider(create: (_) => providers.BountyStore()),
          ChangeNotifierProvider(create: (_) => providers.Champions()),
          ChangeNotifierProvider(create: (_) => providers.Players()),
          ChangeNotifierProvider(create: (_) => providers.Queue()),
          ChangeNotifierProvider(create: (_) => providers.Search()),
        ],
        child: Selector<providers.Auth, ThemeMode>(
          selector: (_, authProvider) => authProvider.settings.themeMode,
          builder: (_, themeMode, __) {
            return MaterialApp(
              navigatorObservers: const [],
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              theme: app_theme.lightTheme,
              darkTheme: app_theme.darkTheme,
              routes: screens.routes,
            );
          },
        ),
      ),
    );
  }
}
