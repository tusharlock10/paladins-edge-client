import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import './Providers/index.dart' as Providers;
import './Screens/index.dart' as Screens;
import './Utilities/Messaging.dart' as Messaging;
import 'AppTheme.dart' as AppTheme;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Messaging.Messaging.onMessage();
  Messaging.Messaging.onBackgroundMessage();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      toastTheme: ToastThemeData(alignment: Alignment.bottomCenter),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Providers.Auth()),
          ChangeNotifierProvider(create: (_) => Providers.BountyStore()),
          ChangeNotifierProvider(create: (_) => Providers.Champions()),
          ChangeNotifierProvider(create: (_) => Providers.Players()),
          ChangeNotifierProvider(create: (_) => Providers.Queue()),
          ChangeNotifierProvider(create: (_) => Providers.Search()),
        ],
        child: Selector<Providers.Auth, ThemeMode>(
          selector: (_, authProvider) => authProvider.settings.themeMode,
          builder: (_, themeMode, __) {
            return MaterialApp(
              navigatorObservers: [],
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              routes: Screens.routes,
            );
          },
        ),
      ),
    );
  }
}
