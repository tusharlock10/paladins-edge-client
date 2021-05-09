import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../Constants.dart' show TypeIds;

part 'Settings.g.dart';

// model for storing user settings locally
@HiveType(typeId: TypeIds.Settings)
class Settings extends HiveObject {
  // 0 means theme is light, 1 means theme is dark
  @HiveField(0)
  int _themeMode = ThemeMode.system == ThemeMode.light ? 0 : 1;

  ThemeMode get themeMode =>
      this._themeMode == 0 ? ThemeMode.light : ThemeMode.dark;

  set themeMode(ThemeMode themeMode) =>
      this._themeMode = themeMode == ThemeMode.light ? 0 : 1;
}
