import "package:hive_flutter/hive_flutter.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/utilities/index.dart" as utilities;

abstract class Database {
  static bool _init = false;
  static models.RecordExpiry? _recordExpiry;

  // create a hive box here
  static Box<String>? _tokenBox;
  static Box<models.User>? _userBox;
  static Box<models.Player>? _playerBox;
  static Box<models.Settings>? _settingsBox;
  static Box<models.Essentials>? _essentialsBox;
  static Box<models.SearchHistory>? _searchHistoryBox;
  static Box<models.Champion>? _championBox;
  static Box<models.RecordExpiry>? _recordExpiryBox;
  static Box<models.PlayerChampion>? _playerChampionBox;
  static Box<models.Queue>? _queueTimelineBox;
  static Box<models.Item>? _itemBox;
  static Box<models.TopMatch>? _topMatchBox;
  static Box<models.BaseRank>? _baseRankBox;

  // getters
  static Box<String>? get tokenBox => _tokenBox;
  static Box<models.User>? get userBox => _userBox;
  static Box<models.Player>? get playerBox => _playerBox;
  static Box<models.Settings>? get settingsBox => _settingsBox;
  static Box<models.Essentials>? get essentialsBox => _essentialsBox;
  static Box<models.SearchHistory>? get searchHistoryBox => _searchHistoryBox;
  static Box<models.Champion>? get championBox => _championBox;
  static Box<models.RecordExpiry>? get recordExpiryBox => _recordExpiryBox;
  static Box<models.PlayerChampion>? get playerChampionBox =>
      _playerChampionBox;
  static Box<models.Queue>? get queueTimelineBox => _queueTimelineBox;
  static Box<models.Item>? get itemBox => _itemBox;
  static Box<models.TopMatch>? get topMatchBox => _topMatchBox;
  static Box<models.BaseRank>? get baseRankBox => _baseRankBox;

  static Future<void> initialize() async {
    if (_init) return;

    utilities.Stopwatch.startStopTimer("initializeDatabase");
    await Hive.initFlutter();
    _registerAdapters();

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
    _playerChampionBox = await Hive.openBox<models.PlayerChampion>(
      constants.HiveBoxes.playerChampion,
    );
    _queueTimelineBox = await Hive.openBox<models.Queue>(
      constants.HiveBoxes.queueTimeline,
    );
    _itemBox = await Hive.openBox<models.Item>(
      constants.HiveBoxes.item,
    );
    _topMatchBox = await Hive.openBox<models.TopMatch>(
      constants.HiveBoxes.topMatch,
    );
    _baseRankBox = await Hive.openBox<models.BaseRank>(
      constants.HiveBoxes.baseRank,
    );

    // check if recordExpiry contains any data
    _recordExpiry = _recordExpiryBox!.get(constants.HiveBoxes.recordExpiry);
    if (_recordExpiry == null) {
      _recordExpiryBox!
          .put(constants.HiveBoxes.recordExpiry, models.RecordExpiry());
      _recordExpiry = _recordExpiryBox!.get(constants.HiveBoxes.recordExpiry);
    }
    utilities.Stopwatch.startStopTimer("initializeDatabase");
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

  static void saveManySearchHistory(List<models.SearchHistory> searchHistory) =>
      _searchHistoryBox?.addAll(searchHistory);

  static void saveChampion(models.Champion champion) =>
      _championBox?.add(champion);

  static void savePlayerChampion(models.PlayerChampion playerChampion) =>
      _playerChampionBox?.add(playerChampion);

  static void saveQueue(models.Queue queue) => _queueTimelineBox?.add(queue);

  static void saveItem(models.Item item) => _itemBox?.add(item);

  static void saveTopMatch(models.TopMatch topMatch) =>
      _topMatchBox?.add(topMatch);

  static void saveBaseRanks(List<models.BaseRank> baseRanks) =>
      _baseRankBox?.addAll(baseRanks);

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
        .isRecordExpired(constants.RecordExpiryName.searchHistory)) {
      // if the data is expired, then clear searchHistory box
      // and renew the recordExpiry for searchHistory
      _searchHistoryBox?.clear();
      _renewRecordExpiry(constants.RecordExpiryName.searchHistory);
    }

    final searchHistory = _searchHistoryBox?.values.toList().reversed.toList();

    return (searchHistory == null || searchHistory.isEmpty)
        ? null
        : searchHistory;
  }

  static List<models.Champion>? getChampions() {
    // check if champion records have expired
    if (_recordExpiry!.isRecordExpired(constants.RecordExpiryName.champion)) {
      // if the data is expired, then clear champion box
      // and renew the recordExpiry for champion records
      _championBox?.clear();
      _renewRecordExpiry(constants.RecordExpiryName.champion);
    }

    final champions = _championBox?.values.toList();

    return champions == null || champions.isEmpty ? null : champions;
  }

  static List<models.PlayerChampion>? getPlayerChampions() {
    // check if playerChampion records have expired
    if (_recordExpiry!
        .isRecordExpired(constants.RecordExpiryName.playerChampion)) {
      // if the data is expired, then clear playerChampion box
      // and renew the recordExpiry for playerChampion records
      _playerChampionBox?.clear();
      _renewRecordExpiry(constants.RecordExpiryName.playerChampion);
    }

    final playerChampions = _playerChampionBox?.values.toList();

    return playerChampions == null || playerChampions.isEmpty
        ? null
        : playerChampions;
  }

  static List<models.Queue>? getQueueTimeline() {
    // check if queueTimeline records have expired
    if (_recordExpiry!
        .isRecordExpired(constants.RecordExpiryName.queueTimeline)) {
      // if the data is expired, then clear queueTimeline box
      // and renew the recordExpiry for queueTimeline records
      _queueTimelineBox?.clear();
      _renewRecordExpiry(constants.RecordExpiryName.queueTimeline);
    }

    final queueTimeline = _queueTimelineBox?.values.toList();

    return queueTimeline == null || queueTimeline.isEmpty
        ? null
        : queueTimeline;
  }

  static List<models.Item>? getItems() {
    // check if item records have expired
    if (_recordExpiry!.isRecordExpired(constants.RecordExpiryName.item)) {
      // if the data is expired, then clear item box
      // and renew the recordExpiry for item records
      _itemBox?.clear();
      _renewRecordExpiry(constants.RecordExpiryName.item);
    }

    final items = _itemBox?.values.toList();

    return items == null || items.isEmpty ? null : items;
  }

  static List<models.TopMatch>? getTopMatches() {
    // check if topMatch records have expired
    if (_recordExpiry!.isRecordExpired(constants.RecordExpiryName.topMatch)) {
      // if the data is expired, then clear topMatch box
      // and renew the recordExpiry for topMatch records
      _topMatchBox?.clear();
      _renewRecordExpiry(constants.RecordExpiryName.topMatch);
    }

    final topMatches = _topMatchBox?.values.toList();

    return topMatches == null || topMatches.isEmpty ? null : topMatches;
  }

  static List<models.BaseRank>? getBaseRanks() {
    // check if baseRank records have expired
    if (_recordExpiry!.isRecordExpired(constants.RecordExpiryName.baseRank)) {
      // if the data is expired, then clear baseRank box
      // and renew the recordExpiry for baseRank records
      _baseRankBox?.clear();
      _renewRecordExpiry(constants.RecordExpiryName.baseRank);
    }

    final ranks = _baseRankBox?.values.toList();

    return ranks == null || ranks.isEmpty ? null : ranks;
  }

  // clear all the boxes
  static Future<void> clear() async {
    final boxes = [
      _tokenBox,
      _userBox,
      _playerBox,
      _settingsBox,
      _searchHistoryBox,
      _playerChampionBox,
    ];
    final futures = boxes.where((_) => _ != null).map((_) => _!.clear());
    await Future.wait(futures);

    _recordExpiryBox!
        .put(constants.HiveBoxes.recordExpiry, models.RecordExpiry());
    _recordExpiry = _recordExpiryBox!.get(constants.HiveBoxes.recordExpiry);

    return;
  }

  static void _registerAdapters() {
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
    Hive.registerAdapter(models.PlayerChampionAdapter());
    Hive.registerAdapter(models.QueueAdapter());
    Hive.registerAdapter(models.QueueRegionAdapter());
    Hive.registerAdapter(models.ItemAdapter());
    Hive.registerAdapter(models.TopMatchAdapter());
    Hive.registerAdapter(models.BaseRankAdapter());
  }

  /// renews the expiry date on saved records.
  ///
  /// Should be called after api calls,
  /// when data has been saved to the local db
  static void _renewRecordExpiry(constants.RecordExpiryName recordName) {
    _recordExpiry?.renewRecordExpiry(recordName);
    _recordExpiry?.save();
  }
}
