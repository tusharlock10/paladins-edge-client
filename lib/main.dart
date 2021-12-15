import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/utilities/messaging.dart' as messaging;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  messaging.Messaging.onMessage();
  messaging.Messaging.onBackgroundMessage();
  messaging.Messaging.registerLocalNotification();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode =
        ref.watch(providers.auth.select((_) => _.settings.themeMode));

    return OverlaySupport.global(
      toastTheme: ToastThemeData(alignment: Alignment.bottomCenter),
      child: MaterialApp(
        navigatorObservers: const [],
        debugShowCheckedModeBanner: false,
        themeMode: themeMode,
        theme: theme.lightTheme,
        darkTheme: theme.darkTheme,
        routes: screens.routes,
      ),
    );
  }
}
