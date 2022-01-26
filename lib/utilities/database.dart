import 'package:hive_flutter/hive_flutter.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/models/index.dart' as models;

abstract class Database {
  static bool _init = false;

  // create a hive box here
  static models.RecordExpiry? _recordExpiry;
  static Box<String>? _tokenBox;
  static Box<models.User>? _userBox;
  static Box<models.Player>? _playerBox;
  static Box<models.Settings>? _settingsBox;
  static Box<models.Essentials>? _essentialsBox;
  static Box<models.SearchHistory>? _searchHistoryBox;
  static Box<models.Champion>? _championBox;
  static Box<models.RecordExpiry>? _recordExpiryBox;
  static Box<models.BountyStore>? _bountyStoreBox;
  static Box<models.PlayerChampion>? _playerChampionBox;

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
    Hive.registerAdapter(models.BountyStoreAdapter());
    Hive.registerAdapter(models.PlayerChampionAdapter());

    _init = true;

    // initialize boxes here
    _tokenBox = await Hive.openBox<String>(constants.HiveBoxes.token);
    _userBox = await Hive.openBox<models.User>(constants.HiveBoxes.user);
    _playerBox = await Hive.openBox<models.Player>(constants.HiveBoxes.player);
    _settingsBox =
        await Hive.openBox<models.Settings>(constants.HiveBoxes.settings);
    _essentialsBox =
        await Hive.openBox<models.Essentials>(constants.HiveBoxes.essentials);
    _searchHistoryBox = await Hive.openBox<models.SearchHistory>(
      constants.HiveBoxes.searchHistory,
    );
    _championBox =
        await Hive.openBox<models.Champion>(constants.HiveBoxes.champion);
    _recordExpiryBox = await Hive.openBox<models.RecordExpiry>(
      constants.HiveBoxes.recordExpiry,
    );
    _bountyStoreBox =
        await Hive.openBox<models.BountyStore>(constants.HiveBoxes.bountyStore);
    _playerChampionBox = await Hive.openBox<models.PlayerChampion>(
      constants.HiveBoxes.playerChampion,
    );

    // check if recordExpiry contains any data
    _recordExpiry = _recordExpiryBox!.get(constants.HiveBoxes.recordExpiry);
    if (_recordExpiry == null) {
      _recordExpiryBox!
          .put(constants.HiveBoxes.recordExpiry, models.RecordExpiry());
      _recordExpiry = _recordExpiryBox!.get(constants.HiveBoxes.recordExpiry);
    }
  }

  // save methods
  static void saveToken(String token) =>
      _tokenBox?.put(constants.HiveBoxes.token, token);

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

  static void saveBountyStore(models.BountyStore bountyStore) =>
      _bountyStoreBox?.add(bountyStore);

  static void savePlayerChampion(models.PlayerChampion playerChampion) =>
      _playerChampionBox?.add(playerChampion);

  // get methods
  static String? getToken() => _tokenBox?.get(constants.HiveBoxes.token);

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

    return searchHistory == null || searchHistory.isEmpty
        ? null
        : searchHistory;
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

    return champions == null || champions.isEmpty ? null : champions;
  }

  static List<models.BountyStore>? getBountyStore() {
    // check if bountyStore records have expired
    if (_recordExpiry!
        .isRecordExpired(constants.RecordExpiryData.bountyStore)) {
      // if the data is expired, then clear bountyStore box
      // and renew the recordExpiry for bountyStore records
      _bountyStoreBox?.clear();
      _renewRecordExpiry(constants.RecordExpiryData.bountyStore);
    }

    final bountyStore = _bountyStoreBox?.values.toList();

    return bountyStore == null || bountyStore.isEmpty ? null : bountyStore;
  }

  static List<models.PlayerChampion>? getPlayerChampions() {
    // check if playerChampion records have expired
    if (_recordExpiry!
        .isRecordExpired(constants.RecordExpiryData.playerChampion)) {
      // if the data is expired, then clear playerChampion box
      // and renew the recordExpiry for playerChampion records
      _playerChampionBox?.clear();
      _renewRecordExpiry(constants.RecordExpiryData.playerChampion);
    }

    final playerChampions = _playerChampionBox?.values.toList();

    return playerChampions == null || playerChampions.isEmpty
        ? null
        : playerChampions;
  }

  // clear all the boxes
  static void clear() {
    _tokenBox?.clear();
    _userBox?.clear();
    _playerBox?.clear();
    _settingsBox?.clear();
    _essentialsBox?.clear();
    _searchHistoryBox?.clear();
    _championBox?.clear();
    _bountyStoreBox?.clear();
    _playerChampionBox?.clear();
  }

  /// renews the expiry date on saved records.
  ///
  /// Should be called after api calls,
  /// when data has been saved to the local db
  static void _renewRecordExpiry(String recordName) {
    _recordExpiry?.renewRecordExpiry(recordName);
    _recordExpiry?.save();
  }
}
