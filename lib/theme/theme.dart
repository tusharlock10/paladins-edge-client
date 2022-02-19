import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:paladinsedge/theme/colors.dart';

/// ThemeData for light theme
final lightTheme = ThemeData(
  primaryColor: themeMaterialColor,
  primaryColorLight: themeMaterialColor,
  primaryColorDark: darkThemeMaterialColor,
  scaffoldBackgroundColor: const Color(0xfff7f7f7),
  appBarTheme: AppBarTheme(
    elevation: 7,
    shadowColor: darkThemeMaterialColor.withOpacity(0.75),
    centerTitle: true,
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 20,
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
    shadowColor: darkThemeMaterialColor.withOpacity(0.25),
    color: Colors.white,
  ),
  textSelectionTheme: TextSelectionThemeData(
    selectionHandleColor: themeMaterialColor.shade100,
    selectionColor: themeMaterialColor.shade100,
    cursorColor: themeMaterialColor.shade100,
  ),
  brightness: Brightness.light,
  fontFamily: GoogleFonts.manrope().fontFamily,
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
    backgroundColor: themeMaterialColor.shade400,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white70,
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: themeMaterialColor,
    brightness: Brightness.light,
  ).copyWith(secondary: darkThemeMaterialColor.shade50),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.white,
  ),
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    labelColor: themeMaterialColor,
    unselectedLabelStyle: TextStyle(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      fontSize: 14,
    ),
    unselectedLabelColor: Colors.grey,
  ),
  dataTableTheme: DataTableThemeData(
    columnSpacing: 32,
    headingRowColor: MaterialStateProperty.all(themeMaterialColor.shade100),
    dataTextStyle: TextStyle(
      fontSize: 14,
      fontFamily: GoogleFonts.montserrat().fontFamily,
    ),
    headingTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: themeMaterialColor.shade50,
  ),
  sliderTheme: SliderThemeData(
    valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
    trackShape: const RoundedRectSliderTrackShape(),
    activeTrackColor: themeMaterialColor.shade100,
    trackHeight: 20,
    thumbColor: Colors.white,
    thumbShape: const RoundSliderThumbShape(
      enabledThumbRadius: 16,
      elevation: 7,
    ),
    showValueIndicator: ShowValueIndicator.never,
  ),
);

/// ThemeData for dark theme
final darkTheme = ThemeData(
  primaryColor: darkThemeMaterialColor,
  primaryColorLight: themeMaterialColor,
  primaryColorDark: darkThemeMaterialColor,
  scaffoldBackgroundColor: darkThemeMaterialColor,
  appBarTheme: AppBarTheme(
    elevation: 7,
    shadowColor: darkThemeMaterialColor.shade50,
    backgroundColor: darkThemeMaterialColor.shade50,
    centerTitle: true,
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 20,
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
    shadowColor: darkThemeMaterialColor.shade50,
    color: darkThemeMaterialColor.shade300,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    selectionHandleColor: Color(0xff4d5c63),
    selectionColor: Color(0xff4d5c63),
    cursorColor: Color(0xff4d5c63),
  ),
  brightness: Brightness.dark,
  fontFamily: GoogleFonts.manrope().fontFamily,
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
    backgroundColor: darkThemeMaterialColor.shade100,
    selectedItemColor: const Color(0xff81b2c7),
    unselectedItemColor: const Color(0xff658999),
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: darkThemeMaterialColor,
    brightness: Brightness.dark,
  ).copyWith(secondary: themeMaterialColor.shade50),
  drawerTheme: DrawerThemeData(
    backgroundColor: darkThemeMaterialColor.shade100,
  ),
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      fontSize: 14,
    ),
    labelColor: Colors.white,
    unselectedLabelStyle: TextStyle(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      fontSize: 14,
    ),
    unselectedLabelColor: Colors.white60,
  ),
  dataTableTheme: DataTableThemeData(
    columnSpacing: 32,
    headingRowColor: MaterialStateProperty.all(darkThemeMaterialColor.shade100),
    dataTextStyle: TextStyle(
      fontSize: 14,
      fontFamily: GoogleFonts.montserrat().fontFamily,
    ),
    headingTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: darkThemeMaterialColor.shade50,
  ),
  sliderTheme: const SliderThemeData(
    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
    trackShape: RoundedRectSliderTrackShape(),
    trackHeight: 20,
    thumbColor: Colors.white,
    thumbShape: RoundSliderThumbShape(
      enabledThumbRadius: 16,
      elevation: 7,
    ),
    showValueIndicator: ShowValueIndicator.never,
  ),
);
