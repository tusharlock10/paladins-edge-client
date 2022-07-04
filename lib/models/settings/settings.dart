import "package:flutter/material.dart";
import "package:hive/hive.dart";
import "package:paladinsedge/constants/index.dart" show TypeIds;

part "settings.g.dart";

// model for storing user settings locally
@HiveType(typeId: TypeIds.settings)
class Settings extends HiveObject {
  // initialize _themeMode to the system theme
  /// 0 means theme is system based, 1 means light theme, 2 means dark theme
  @HiveField(0)
  int _themeMode = 0;

  ThemeMode get themeMode {
    switch (_themeMode) {
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  set themeMode(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        _themeMode = 1;
        break;
      case ThemeMode.dark:
        _themeMode = 2;
        break;
      default:
        _themeMode = 0;
        break;
    }
  }
}
