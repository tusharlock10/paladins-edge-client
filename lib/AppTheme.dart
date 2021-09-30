import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

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

final lightTheme = ThemeData(
  primaryColor: ThemeMaterialColor,
  primaryColorLight: ThemeMaterialColor,
  primaryColorDark: DarkThemeMaterialColor,
  primaryColorBrightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white.withOpacity(0.96),
  appBarTheme: AppBarTheme(
    elevation: 7,
    shadowColor: DarkThemeMaterialColor.withOpacity(0.75),
    centerTitle: true,
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 16,
    ),
    toolbarTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: GoogleFonts.raleway().fontFamily,
      fontWeight: FontWeight.bold,
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
    headline3: TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    bodyText1: TextStyle(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      color: Colors.black54,
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
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: ThemeMaterialColor,
    brightness: Brightness.light,
  ).copyWith(secondary: DarkThemeMaterialColor.shade50),
);

final darkTheme = ThemeData(
  primaryColor: DarkThemeMaterialColor,
  primaryColorLight: ThemeMaterialColor,
  primaryColorDark: DarkThemeMaterialColor,
  primaryColorBrightness: Brightness.dark,
  scaffoldBackgroundColor: DarkThemeMaterialColor,
  appBarTheme: AppBarTheme(
    elevation: 7,
    shadowColor: DarkThemeMaterialColor.shade50,
    backgroundColor: DarkThemeMaterialColor.shade50,
    centerTitle: true,
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 16,
    ),
    toolbarTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: GoogleFonts.raleway().fontFamily,
      fontWeight: FontWeight.bold,
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
    headline3: TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    bodyText1: TextStyle(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      color: Colors.white54,
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
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: DarkThemeMaterialColor,
    brightness: Brightness.dark,
  ).copyWith(secondary: ThemeMaterialColor.shade50),
);
