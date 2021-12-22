import 'package:hive_flutter/hive_flutter.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/models/index.dart' as models;

abstract class Database {
  static bool _init = false;

  static models.RecordExpiry? _recordExpiry;
  static Box<models.User>? _userBox;
  static Box<models.Player>? _playerBox;
  static Box<models.Settings>? _settingsBox;
  static Box<models.Essentials>? _essentialsBox;
  static Box<models.SearchHistory>? _searchHistoryBox;
  static Box<models.Champion>? _championBox;
  static Box<models.RecordExpiry>? _recordExpiryBox;

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
    Hive.registerAdapter(models.SearchHistoryAdapter());
    Hive.registerAdapter(models.RecordExpiryAdapter());

    _init = true;

    _userBox = await Hive.openBox<models.User>(constants.HiveBoxes.user);
    _playerBox = await Hive.openBox<models.Player>(constants.HiveBoxes.player);
    _settingsBox =
        await Hive.openBox<models.Settings>(constants.HiveBoxes.settings);
    _essentialsBox =
        await Hive.openBox<models.Essentials>(constants.HiveBoxes.essentials);
    _searchHistoryBox = await Hive.openBox<models.SearchHistory>(
        constants.HiveBoxes.searchHistory);
    _championBox =
        await Hive.openBox<models.Champion>(constants.HiveBoxes.champion);
    _recordExpiryBox = await Hive.openBox<models.RecordExpiry>(
        constants.HiveBoxes.recordExpiry);

    // check if recordExpiry contains any data
    _recordExpiry = _recordExpiryBox!.get(constants.HiveBoxes.recordExpiry);
    if (_recordExpiry == null) {
      _recordExpiryBox!
          .put(constants.HiveBoxes.recordExpiry, models.RecordExpiry());
      _recordExpiry = _recordExpiryBox!.get(constants.HiveBoxes.recordExpiry);
    }
  }

  // record expiry methods

  /// renews the expiry date on saved records.
  ///
  /// Should be called after api calls,
  /// when data has been saved to the local db
  static void _renewRecordExpiry(String recordName) {
    _recordExpiry?.renewRecordExpiry(recordName);
    _recordExpiry?.save();
  }

  // save methods
  static void saveUser(models.User user) =>
      _userBox?.put(constants.HiveBoxes.user, user);

  static void savePlayer(models.Player player) =>
      _playerBox?.put(constants.HiveBoxes.player, player);

  static void saveSettings(models.Settings settings) =>
      _settingsBox?.put(constants.HiveBoxes.settings, settings);

  static void saveEssentials(models.Essentials essentials) =>
      _essentialsBox?.put(constants.HiveBoxes.essentials, essentials);

  static void saveSearchHistory(models.SearchHistory searchItem) =>
      _searchHistoryBox?.add(searchItem);

  static void saveChampion(models.Champion champion) =>
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

  static List<models.SearchHistory>? getSearchHistory() {
    // check if searchHistory have expired
    if (_recordExpiry!
        .isRecordExpired(constants.RecordExpiryData.searchHistory)) {
      // if the data is expired, then clear searchHistory box
      // and renew the recordExpiry for searchHistory
      _searchHistoryBox?.clear();
      _renewRecordExpiry(constants.RecordExpiryData.searchHistory);
    }

    final searchHistory = _searchHistoryBox?.values.toList().reversed.toList();

    if (searchHistory == null || searchHistory.isEmpty) {
      return null;
    } else {
      return searchHistory;
    }
  }

  static List<models.Champion>? getChampions() {
    // check if champion records have expired
    if (_recordExpiry!.isRecordExpired(constants.RecordExpiryData.champion)) {
      // if the data is expired, then clear champion box
      // and renew the recordExpiry for champion records
      _championBox?.clear();
      _renewRecordExpiry(constants.RecordExpiryData.champion);
    }

    final champions = _championBox?.values.toList();

    if (champions == null || champions.isEmpty) {
      return null;
    } else {
      return champions;
    }
  }

  static void clear() {
    _userBox?.clear();
    _playerBox?.clear();
    _settingsBox?.clear();
    _essentialsBox?.clear();
    _searchHistoryBox?.clear();
    _championBox?.clear();
  }
}
