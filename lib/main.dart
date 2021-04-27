import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import './Providers/index.dart' as Providers;
import './Screens/index.dart' as Screens;
import './Constants.dart' as Constants;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Providers.Champions()),
        ChangeNotifierProvider(create: (_) => Providers.Search()),
        ChangeNotifierProvider(create: (_) => Providers.Auth()),
        ChangeNotifierProvider(create: (_) => Providers.Queue()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          accentColor: Constants.ThemeMaterialColor.shade200,
          textSelectionTheme: TextSelectionThemeData(
            selectionHandleColor: Constants.ThemeMaterialColor.shade900,
            selectionColor: Constants.ThemeMaterialColor.shade900,
            cursorColor: Constants.ThemeMaterialColor.shade900,
          ),
          primarySwatch: Constants.ThemeMaterialColor,
          brightness: Brightness.light,
          fontFamily: GoogleFonts.manrope().fontFamily,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Constants.ThemeMaterialColor),
            ),
          ),
          primaryTextTheme: TextTheme(
            headline6: TextStyle(
              fontFamily: GoogleFonts.raleway().fontFamily,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        routes: Screens.routes,
      ),
    );
  }
}
