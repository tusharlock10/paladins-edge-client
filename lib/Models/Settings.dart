import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../Constants.dart' show TypeIds;

part 'Settings.g.dart';

// model for storing user settings locally
@HiveType(typeId: TypeIds.Settings)
class Settings extends HiveObject {
  // 0 means theme is system based, 1 means light theme, 2 means dark theme

  // initialize _themeMode to the system theme
  @HiveField(0)
  int _themeMode = 0;

  ThemeMode get themeMode {
    switch (this._themeMode) {
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
        this._themeMode = 1;
        break;
      case ThemeMode.dark:
        this._themeMode = 2;
        break;
      default:
        this._themeMode = 0;
        break;
    }
  }
}
