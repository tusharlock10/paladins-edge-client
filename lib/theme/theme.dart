import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:paladinsedge/theme/colors.dart';

final lightTheme = ThemeData(
  primaryColor: themeMaterialColor,
  primaryColorLight: themeMaterialColor,
  primaryColorDark: darkthemeMaterialColor,
  primaryColorBrightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xfff7f7f7),
  appBarTheme: AppBarTheme(
    elevation: 7,
    shadowColor: darkthemeMaterialColor.withOpacity(0.75),
    centerTitle: true,
    iconTheme: const IconThemeData(
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
    shadowColor: darkthemeMaterialColor.withOpacity(0.25),
    color: Colors.white,
  ),
  textSelectionTheme: TextSelectionThemeData(
    selectionHandleColor: themeMaterialColor.shade100,
    selectionColor: themeMaterialColor.shade100,
    cursorColor: themeMaterialColor.shade100,
  ),
  brightness: Brightness.light,
  fontFamily: GoogleFonts.manrope().fontFamily,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(themeMaterialColor),
    ),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      color: themeMaterialColor,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: themeMaterialColor,
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
    selectedItemColor: themeMaterialColor.shade400,
    unselectedItemColor: themeMaterialColor.shade400,
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: themeMaterialColor,
    brightness: Brightness.light,
  ).copyWith(secondary: darkthemeMaterialColor.shade50),
);

final darkTheme = ThemeData(
  primaryColor: darkthemeMaterialColor,
  primaryColorLight: themeMaterialColor,
  primaryColorDark: darkthemeMaterialColor,
  primaryColorBrightness: Brightness.dark,
  scaffoldBackgroundColor: darkthemeMaterialColor,
  appBarTheme: AppBarTheme(
    elevation: 7,
    shadowColor: darkthemeMaterialColor.shade50,
    backgroundColor: darkthemeMaterialColor.shade50,
    centerTitle: true,
    iconTheme: const IconThemeData(
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
    shadowColor: darkthemeMaterialColor.shade50,
    color: darkthemeMaterialColor.shade300,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionHandleColor: Color(0xff4d5c63),
    selectionColor: Color(0xff4d5c63),
    cursorColor: Color(0xff4d5c63),
  ),
  brightness: Brightness.dark,
  fontFamily: GoogleFonts.manrope().fontFamily,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(darkthemeMaterialColor),
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
    backgroundColor: darkthemeMaterialColor.shade400,
    selectedItemColor: const Color(0xff81b2c7),
    unselectedItemColor: const Color(0xff658999),
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: darkthemeMaterialColor,
    brightness: Brightness.dark,
  ).copyWith(secondary: themeMaterialColor.shade50),
  drawerTheme:
      DrawerThemeData(backgroundColor: darkthemeMaterialColor.shade100),
);
