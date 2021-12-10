import 'package:hive_flutter/hive_flutter.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/models/index.dart' as models;

abstract class Database {
  static bool _init = false;
  static Box<models.User>? _userBox;
  static Box<models.Player>? _playerBox;
  static Box<models.Settings>? _settingsBox;
  static Box<models.Essentials>? _essentialsBox;
  static Box<models.SearchHistory>? _searchHistoryBox;
  static Box<models.Champion>? _championBox;

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
    Hive.registerAdapter(models.EssentialsAdapter());

    _init = true;
    _userBox = await Hive.openBox<models.User>(constants.HiveBoxes.user);
    _playerBox = await Hive.openBox<models.Player>(constants.HiveBoxes.player);
    _settingsBox =
        await Hive.openBox<models.Settings>(constants.HiveBoxes.settings);
    _essentialsBox =
        await Hive.openBox<models.Essentials>(constants.HiveBoxes.essentials);
    _searchHistoryBox = await Hive.openBox(constants.HiveBoxes.searchHistory);
  }

  // set methods
  static void setUser(models.User user) =>
      _userBox?.put(constants.HiveBoxes.user, user);

  static void setPlayer(models.Player player) =>
      _playerBox?.put(constants.HiveBoxes.player, player);

  static void setSettings(models.Settings settings) =>
      _settingsBox?.put(constants.HiveBoxes.settings, settings);

  static void setEssentials(models.Essentials essentials) =>
      _essentialsBox?.put(constants.HiveBoxes.essentials, essentials);

  static void addSearchItem(models.SearchHistory searchItem) =>
      _searchHistoryBox?.add(searchItem);

  static void addChampion(models.Champion champion) =>
      _championBox?.add(champion);

  // get methods
  static models.User? getUser() => _userBox?.get(constants.HiveBoxes.user);

  static models.Player? getPlayer() =>
      _playerBox?.get(constants.HiveBoxes.player);

  static models.Settings getSettings() {
    final settings = _settingsBox?.get(constants.HiveBoxes.settings);
    if (settings == null) return models.Settings();
    return settings;
  }

  static models.Essentials? getEssentials() =>
      _essentialsBox?.get(constants.HiveBoxes.essentials);

  static List<models.SearchHistory>? getSearchHistory() =>
      _searchHistoryBox?.values.toList().reversed.toList();

  static List<models.Champion>? getChampions() => _championBox?.values.toList();

  static void clear() {
    _userBox?.clear();
    _playerBox?.clear();
    _settingsBox?.clear();
    _essentialsBox?.clear();
    _searchHistoryBox?.clear();
    _championBox?.clear();
  }
}
