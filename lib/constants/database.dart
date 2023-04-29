import "package:paladinsedge/constants/environment.dart";

const databaseVersion = 2;

abstract class HiveBoxes {
  static String get token => getBoxName("token");
  static String get user => getBoxName("user");
  static String get player => getBoxName("player");
  static String get settings => getBoxName("settings");
  static String get essentials => getBoxName("essentials");
  static String get searchHistory => getBoxName("searchHistory");
  static String get champion => getBoxName("champion");
  static String get recordExpiry => getBoxName("recordExpiry");
  static String get playerChampion => getBoxName("playerChampion");
  static String get queueTimeline => getBoxName("queueTimeline");
  static String get item => getBoxName("item");
  static String get topMatch => getBoxName("topMatch");

  static get allBoxes => [
        token,
        user,
        player,
        settings,
        essentials,
        searchHistory,
        champion,
        recordExpiry,
        playerChampion,
        queueTimeline,
        item,
        topMatch,
      ];

  static String getBoxName(String name) {
    final env = Env.appType;
    final boxName = "$name-$env-$databaseVersion";

    return boxName;
  }
}

enum RecordExpiryName {
  champion,
  searchHistory,
  playerChampion,
  queueTimeline,
  item,
  topMatch,
}

abstract class RecordExpiryDuration {
  // Time to live duration of these records
  static const championDuration = Duration(days: 1);
  static const searchHistoryDuration = Duration(hours: 1);
  static const playerChampionDuration = Duration(days: 1);
  static const queueTimelineDuration = Duration(minutes: 30);
  static const itemDuration = Duration(days: 1);
  static const topMatchDuration = Duration(hours: 6);
}

abstract class TypeIds {
  // when adding another type id, add it at the bottom with a unique
  // incremental id, do not change the value of the fields above it
  static const champion = 0;
  static const championAbility = 1;
  static const championTalent = 2;
  static const championCard = 3;
  static const player = 4;
  static const playerRanked = 5;
  static const user = 6;
  static const settings = 7;
  static const championTag = 8;
  static const playerChampion = 9;
  static const essentials = 10;
  static const searchHistory = 11;
  static const recordExpiry = 12;
  static const queue = 14;
  static const item = 15;
  static const queueRegion = 16;
  static const topMatch = 17;
}

abstract class StorageKeys {
  static const token = "token";
}
