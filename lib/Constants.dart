import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Urls {
  // root
  static const root = "/";

  // auth
  static const login = "/auth/login"; // POST
  static const logout = "/auth/logout"; // POST
  static const fcmToken = "/auth/fcmToken"; // POST
  static const claimPlayer = "/auth/claimPlayer"; // POST
  static const observePlayer = "/auth/observePlayer"; // POST

  // champions
  static const allChampions = "/champions/allChampions"; // GET

  // players
  static const searchPlayers = "/players/searchPlayers"; // GET
  static const playerDetail = "/players/playerDetail"; // GET

  // queue
  static const queueDetails = "/queue/queueDetails"; // GET
}

abstract class StorageKeys {
  static const token = 'token';
}

const Map<int, Color> _colorValues = {
  50: Color.fromRGBO(101, 214, 255, 1),
  100: Color.fromRGBO(101, 214, 255, 1),
  200: Color.fromRGBO(101, 214, 255, 1),
  300: Color.fromRGBO(101, 214, 255, 1),
  400: Color.fromRGBO(25, 165, 207, 1),
  500: Color.fromRGBO(25, 165, 207, 1),
  600: Color.fromRGBO(25, 165, 207, 1),
  700: Color.fromRGBO(0, 118, 158, 1),
  800: Color.fromRGBO(0, 118, 158, 1),
  900: Color.fromRGBO(0, 118, 158, 1),
};

const ThemeMaterialColor = MaterialColor(0xFF19a5cf, _colorValues);

const Map<int, Color> _darkColorValues = {
  50: Color.fromRGBO(44, 60, 67, 1),
  100: Color.fromRGBO(44, 60, 67, 1),
  200: Color.fromRGBO(44, 60, 67, 1),
  300: Color.fromRGBO(44, 60, 67, 1),
  400: Color.fromRGBO(4, 22, 28, 1),
  500: Color.fromRGBO(4, 22, 28, 1),
  600: Color.fromRGBO(4, 22, 28, 1),
  700: Color.fromRGBO(0, 0, 0, 1),
  800: Color.fromRGBO(0, 0, 0, 1),
  900: Color.fromRGBO(0, 0, 0, 1),
};

const DarkThemeMaterialColor = MaterialColor(0xFF04161c, _darkColorValues);

const IsDebug = kDebugMode;

const BaseUrl =
    IsDebug ? "http://192.168.0.103:8000" : "https://api.paladinsedge.ml";

const ApiTimeout = IsDebug ? 10 * 1000 : 20 * 1000;

const OtpSalt = "EszqnsYd";

abstract class TypeIds {
  // when adding another type id, add it in the
  // bottom with a unique id, do not change the value of the filds above it
  static const Champion = 0;
  static const Champion_Ability = 1;
  static const Champion_Talent = 2;
  static const Champion_Card = 3;
  static const Player = 4;
  static const Player_Ranked = 5;
  static const User = 6;
  static const Settings = 7;
}

final lightTheme = ThemeData(
  primaryColorBrightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  accentColor: ThemeMaterialColor.shade200,
  textSelectionTheme: TextSelectionThemeData(
    selectionHandleColor: ThemeMaterialColor.shade100,
    selectionColor: ThemeMaterialColor.shade100,
    cursorColor: ThemeMaterialColor.shade100,
  ),
  primarySwatch: ThemeMaterialColor,
  brightness: Brightness.light,
  fontFamily: GoogleFonts.manrope().fontFamily,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(ThemeMaterialColor),
    ),
  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(
      fontFamily: GoogleFonts.raleway().fontFamily,
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: ThemeMaterialColor.shade400,
    unselectedItemColor: ThemeMaterialColor.shade400,
  ),
);

final darkTheme = ThemeData(
  primaryColorBrightness: Brightness.dark,
  scaffoldBackgroundColor: DarkThemeMaterialColor,
  accentColor: DarkThemeMaterialColor.shade200,
  cardTheme: CardTheme(
      color: DarkThemeMaterialColor.shade300,
      shadowColor: DarkThemeMaterialColor.shade50),
  textSelectionTheme: TextSelectionThemeData(
    selectionHandleColor: Color(0xff4d5c63),
    selectionColor: Color(0xff4d5c63),
    cursorColor: Color(0xff4d5c63),
  ),
  primarySwatch: DarkThemeMaterialColor,
  brightness: Brightness.light,
  fontFamily: GoogleFonts.manrope().fontFamily,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(DarkThemeMaterialColor),
    ),
  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(
      fontFamily: GoogleFonts.raleway().fontFamily,
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: DarkThemeMaterialColor.shade200,
    selectedItemColor: Color(0xff81b2c7),
    unselectedItemColor: Color(0xff658999),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: DarkThemeMaterialColor.shade200,
  ),
);
