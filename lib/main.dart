import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import './Providers/index.dart' as Providers;
import './Screens/index.dart' as Screens;

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarBrightness: Brightness.light,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Providers.Champions()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blueGrey,
          brightness: Brightness.light,
          fontFamily: GoogleFonts.manrope().fontFamily,
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
