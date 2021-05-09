import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';

import './Providers/index.dart' as Providers;
import './Screens/index.dart' as Screens;
import './Constants.dart' as Constants;
import './Utilities/messaging.dart' as Messaging;

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
          ChangeNotifierProvider(create: (_) => Providers.Champions()),
          ChangeNotifierProvider(create: (_) => Providers.Search()),
          ChangeNotifierProvider(create: (_) => Providers.Auth()),
          ChangeNotifierProvider(create: (_) => Providers.Queue()),
        ],
        child: Selector<Providers.Auth, ThemeMode>(
          selector: (_, authProvider) => authProvider.settings.themeMode,
          builder: (_, themeMode, __) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              theme: Constants.lightTheme,
              darkTheme: Constants.darkTheme,
              routes: Screens.routes,
            );
          },
        ),
      ),
    );
  }
}
