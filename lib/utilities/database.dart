import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paladinsedge/models/index.dart' as models;

abstract class Database {
  static Box<models.User>? _userBox;
  static Box<models.Player>? _playerBox;
  static Box<models.Settings>? _settingsBox;
  static Box? _searchHistoryBox;
  static bool _init = false;

  static Future<void> initDatabase() async {
    if (_init) return;
    await Hive.initFlutter();
    // register the generated adapters here
    Hive.registerAdapter(models.ChampionAdapter());
    Hive.registerAdapter(models.AbilityAdapter());
    Hive.registerAdapter(models.TalentAdapter());
    Hive.registerAdapter(models.CardAdapter());
    Hive.registerAdapter(models.PlayerAdapter());
    Hive.registerAdapter(models.RankedAdapter());
    Hive.registerAdapter(models.UserAdapter());
    Hive.registerAdapter(models.SettingsAdapter());

    _init = true;
    _userBox = await Hive.openBox<models.User>('user');
    _playerBox = await Hive.openBox<models.Player>('player');
    _settingsBox = await Hive.openBox<models.Settings>('settings');
    _searchHistoryBox = await Hive.openBox('searchHistory');
  }

  // set methods
  static void setUser(models.User user) => _userBox?.put('user', user);

  static void setPlayer(models.Player player) =>
      _playerBox?.put('player', player);

  static void setSettings(models.Settings settings) =>
      _settingsBox?.put('settings', settings);

  static void addSearchItem(Map<String, dynamic> searchItem) =>
      _searchHistoryBox?.add(searchItem);

  // get methods
  static models.User? getUser() => _userBox?.get('user');

  static models.Player? getPlayer() => _playerBox?.get('player');

  static models.Settings? getSettings() => _settingsBox?.get('settings');

  static List<Map<String, dynamic>> getSearchHistory() {
    final json = _searchHistoryBox?.values;
    if (json == null) {
      return [];
    }
    final searchHistory = json
        .map((item) => Map<String, dynamic>.from(item as Map<dynamic, dynamic>))
        .toList();
    return searchHistory.reversed.toList();
  }

  static void clear() {
    _userBox?.clear();
    _playerBox?.clear();
    _settingsBox?.clear();
    _searchHistoryBox?.clear();
  }
}
