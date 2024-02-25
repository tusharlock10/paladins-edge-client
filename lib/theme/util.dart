import "package:flutter/material.dart";

abstract class ThemeUtil {
  static const light = "light";
  static const dark = "dark";
  static const system = "system";

  static getThemeName(ThemeMode themeMode) {
    if (themeMode == ThemeMode.system) return system;
    if (themeMode == ThemeMode.dark) return dark;

    return light;
  }

  static cycleThemeMode(ThemeMode themeMode) {
    if (themeMode == ThemeMode.system) return ThemeMode.dark;
    if (themeMode == ThemeMode.dark) return ThemeMode.light;

    return ThemeMode.system;
  }
}
