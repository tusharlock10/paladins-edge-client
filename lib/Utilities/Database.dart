import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Models/index.dart' as Models;

abstract class Database {
  static Box<Models.User>? _userBox;
  static Box<Models.Player>? _playerBox;
  static Box<Models.Settings>? _settingsBox;
  static Box? _searchHistoryBox;
  static bool _init = false;

  static Future<void> initDatabase() async {
    if (_init) return;
    await Hive.initFlutter();
    // register the generated adapters here
    Hive.registerAdapter(Models.ChampionAdapter());
    Hive.registerAdapter(Models.AbilityAdapter());
    Hive.registerAdapter(Models.TalentAdapter());
    Hive.registerAdapter(Models.CardAdapter());
    Hive.registerAdapter(Models.PlayerAdapter());
    Hive.registerAdapter(Models.RankedAdapter());
    Hive.registerAdapter(Models.UserAdapter());
    Hive.registerAdapter(Models.SettingsAdapter());

    _init = true;
    _userBox = await Hive.openBox<Models.User>('user');
    _playerBox = await Hive.openBox<Models.Player>('player');
    _settingsBox = await Hive.openBox<Models.Settings>('settings');
    _searchHistoryBox = await Hive.openBox('searchHistory');
  }

  // set methods
  static void setUser(Models.User user) => _userBox?.put('user', user);

  static void setPlayer(Models.Player player) =>
      _playerBox?.put('player', player);

  static void setSettings(Models.Settings settings) =>
      _settingsBox?.put('settings', settings);

  static void addSearchItem(Map<String, dynamic> searchItem) =>
      _searchHistoryBox?.add(searchItem);

  // get methods
  static Models.User? getUser() => _userBox?.get('user');

  static Models.Player? getPlayer() => _playerBox?.get('player');

  static Models.Settings? getSettings() => _settingsBox?.get('settings');

  static List<Map<String, dynamic>> getSearchHistory() {
    final json = _searchHistoryBox?.values;
    if (json == null) {
      return [];
    }
    final searchHistory =
        json.map((item) => Map<String, dynamic>.from(item)).toList();
    return searchHistory.reversed.toList();
  }

  static void clear() {
    _userBox?.clear();
    _playerBox?.clear();
    _settingsBox?.clear();
    _searchHistoryBox?.clear();
  }
}
