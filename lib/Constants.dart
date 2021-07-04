import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

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
  static const playerChampionsData = "/champions/playerChampionsData"; // GET

  // players
  static const searchPlayers = "/players/searchPlayers"; // GET
  static const playerDetail = "/players/playerDetail"; // GET
  static const playerStatus = "/playerStatus"; // GET

  // queue
  static const queueDetails = "/queue/queueDetails"; // GET
}

abstract class StorageKeys {
  static const token = "token";
}

const Map<int, Color> _colorValues = {
  50: Color.fromRGBO(217, 245, 255, 1),
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
  50: Color.fromRGBO(63, 87, 97, 1),
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
  static const Champion_Tag = 8;
  static const PlayerChampion = 9;
}

final lightTheme = ThemeData(
  primaryColor: ThemeMaterialColor,
  primaryColorLight: ThemeMaterialColor,
  primaryColorDark: DarkThemeMaterialColor,
  primaryColorBrightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white.withOpacity(0.96),
  accentColor: DarkThemeMaterialColor.shade50,
  appBarTheme: AppBarTheme(
    elevation: 7,
    shadowColor: DarkThemeMaterialColor.withOpacity(0.75),
    centerTitle: true,
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 16,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: GoogleFonts.raleway().fontFamily,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  cardTheme: CardTheme(
    elevation: 4,
    shadowColor: DarkThemeMaterialColor.withOpacity(0.25),
    color: Colors.white,
  ),
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
    headline1: TextStyle(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      color: ThemeMaterialColor,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: ThemeMaterialColor,
      fontWeight: FontWeight.bold,
    ),
    bodyText2: TextStyle(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      fontSize: 12,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: ThemeMaterialColor.shade400,
    unselectedItemColor: ThemeMaterialColor.shade400,
  ),
);

final darkTheme = ThemeData(
  primaryColor: DarkThemeMaterialColor,
  primaryColorLight: ThemeMaterialColor,
  primaryColorDark: DarkThemeMaterialColor,
  primaryColorBrightness: Brightness.dark,
  scaffoldBackgroundColor: DarkThemeMaterialColor,
  accentColor: ThemeMaterialColor.shade50,
  appBarTheme: AppBarTheme(
    elevation: 7,
    shadowColor: DarkThemeMaterialColor.shade50,
    backgroundColor: DarkThemeMaterialColor.shade50,
    centerTitle: true,
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 16,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: GoogleFonts.raleway().fontFamily,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  cardTheme: CardTheme(
    elevation: 4,
    shadowColor: DarkThemeMaterialColor.shade50,
    color: DarkThemeMaterialColor.shade300,
  ),
  textSelectionTheme: TextSelectionThemeData(
    selectionHandleColor: Color(0xff4d5c63),
    selectionColor: Color(0xff4d5c63),
    cursorColor: Color(0xff4d5c63),
  ),
  primarySwatch: DarkThemeMaterialColor,
  brightness: Brightness.dark,
  fontFamily: GoogleFonts.manrope().fontFamily,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(DarkThemeMaterialColor),
    ),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    bodyText2: TextStyle(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      fontSize: 12,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: DarkThemeMaterialColor.shade200,
    selectedItemColor: Color(0xff81b2c7),
    unselectedItemColor: Color(0xff658999),
  ),
);

const Map<String, Map<String, dynamic>> ChampionDamageType = {
  'Area Damage': {"name": "Area Damage", "color": Colors.red},
  'Crowd Control': {"name": "Crowd Control", "color": Colors.teal},
  'Direct Damage': {"name": "Direct Damage", "color": Colors.red},
  'Heal': {"name": "Heal", "color": Colors.green},
  'Movement': {"name": "Movement", "color": Colors.amber},
  'Protective': {"name": "Protective", "color": Colors.lightBlue},
  'Reveal': {"name": "Reveal", "color": Colors.amber},
  'Shield': {"name": "Shield", "color": Colors.indigo},
  'Stealth': {"name": "Stealth", "color": Colors.blue},
};
