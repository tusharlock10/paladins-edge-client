import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:paladinsedge/theme/colors.dart";
import "package:paladinsedge/theme/fonts.dart";

/// ThemeData for light theme
final lightTheme = ThemeData(
  primaryColor: themeMaterialColor,
  primaryColorLight: themeMaterialColor,
  primaryColorDark: darkThemeMaterialColor,
  scaffoldBackgroundColor: const Color(0xfff7f7f7),
  appBarTheme: AppBarTheme(
    elevation: 7,
    shadowColor: darkThemeMaterialColor.withOpacity(0.25),
    centerTitle: true,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 20,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: Fonts.primary,
    ),
    toolbarTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: Fonts.secondary,
      fontWeight: FontWeight.bold,
    ),
  ),
  cardTheme: CardTheme(
    elevation: 4,
    shadowColor: darkThemeMaterialColor.withOpacity(0.25),
    color: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(7),
      shadowColor:
          MaterialStateProperty.all(darkThemeMaterialColor.withOpacity(0.35)),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    selectionHandleColor: themeMaterialColor.shade300,
    selectionColor: themeMaterialColor.shade300,
    cursorColor: themeMaterialColor.shade300,
  ),
  brightness: Brightness.light,
  fontFamily: Fonts.primaryAccent,
  textTheme: TextTheme(
    headline1: TextStyle(
      fontFamily: Fonts.secondaryAccent,
      color: themeMaterialColor,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontFamily: Fonts.primary,
      color: themeMaterialColor,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      fontFamily: Fonts.primary,
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    bodyText1: TextStyle(
      fontFamily: Fonts.secondaryAccent,
      color: Colors.black54,
    ),
    bodyText2: TextStyle(
      fontFamily: Fonts.secondaryAccent,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      fontFamily: Fonts.secondaryAccent,
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
      fontFamily: Fonts.secondaryAccent,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    labelColor: themeMaterialColor,
    unselectedLabelStyle: TextStyle(
      fontFamily: Fonts.secondaryAccent,
      fontSize: 14,
    ),
    unselectedLabelColor: Colors.grey,
  ),
  dataTableTheme: DataTableThemeData(
    columnSpacing: 32,
    headingRowColor: MaterialStateProperty.all(themeMaterialColor.shade100),
    dataTextStyle: TextStyle(
      fontSize: 14,
      fontFamily: Fonts.secondaryAccent,
    ),
    headingTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: Fonts.primary,
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
  popupMenuTheme: PopupMenuThemeData(
    elevation: 25,
    textStyle: TextStyle(
      fontFamily: Fonts.secondaryAccent,
      color: Colors.black,
      fontStyle: FontStyle.italic,
      fontSize: 12,
    ),
    color: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
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
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 20,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: Fonts.primary,
    ),
    toolbarTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontFamily: Fonts.secondary,
      fontWeight: FontWeight.bold,
    ),
  ),
  cardTheme: CardTheme(
    elevation: 4,
    shadowColor: darkThemeMaterialColor.shade50,
    color: darkThemeMaterialColor.shade300,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(7),
      shadowColor: MaterialStateProperty.all(darkThemeMaterialColor.shade50),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    selectionHandleColor: darkThemeMaterialColor.shade300,
    selectionColor: darkThemeMaterialColor.shade300,
    cursorColor: darkThemeMaterialColor.shade300,
  ),
  brightness: Brightness.dark,
  fontFamily: Fonts.primaryAccent,
  textTheme: TextTheme(
    headline1: TextStyle(
      fontFamily: Fonts.secondaryAccent,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      fontFamily: Fonts.primary,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      fontFamily: Fonts.primary,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    bodyText1: TextStyle(
      fontFamily: Fonts.secondaryAccent,
      color: Colors.white54,
    ),
    bodyText2: TextStyle(
      fontFamily: Fonts.secondaryAccent,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      fontFamily: Fonts.secondaryAccent,
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
      fontFamily: Fonts.secondaryAccent,
      fontSize: 14,
    ),
    labelColor: Colors.white,
    unselectedLabelStyle: TextStyle(
      fontFamily: Fonts.secondaryAccent,
      fontSize: 14,
    ),
    unselectedLabelColor: Colors.white60,
  ),
  dataTableTheme: DataTableThemeData(
    columnSpacing: 32,
    headingRowColor: MaterialStateProperty.all(darkThemeMaterialColor.shade100),
    dataTextStyle: TextStyle(
      fontSize: 14,
      fontFamily: Fonts.secondaryAccent,
    ),
    headingTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: Fonts.primary,
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
  popupMenuTheme: PopupMenuThemeData(
    elevation: 25,
    textStyle: TextStyle(
      fontFamily: Fonts.secondaryAccent,
      color: Colors.white,
      fontStyle: FontStyle.italic,
      fontSize: 12,
    ),
    color: darkThemeMaterialColor.shade300,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
  ),
);
