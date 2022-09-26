import "package:flutter/material.dart" show ThemeMode;
import "package:hive/hive.dart";
import "package:paladinsedge/constants/index.dart" show TypeIds;
import "package:paladinsedge/data_classes/common/region.dart" show Region;

part "settings.g.dart";

// model for storing user settings locally
@HiveType(typeId: TypeIds.settings)
class Settings extends HiveObject {
  /// Used to check whether to show other playerMatches or user playerMatches
  /// in commonMatches
  @HiveField(1, defaultValue: false)
  bool showUserPlayerMatches = false;

  /// Used to store the value of selected queue by user in db
  @HiveField(2, defaultValue: Region.all)
  String selectedQueueRegion = Region.all;

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
