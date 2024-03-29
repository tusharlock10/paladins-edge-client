abstract class HiveBoxes {
  static const token = "token";
  static const user = "user";
  static const player = "player";
  static const settings = "settings";
  static const essentials = "essentials";
  static const searchHistory = "searchHistory";
  static const champion = "champion";
  static const recordExpiry = "recordExpiry";
  static const playerChampion = "playerChampion";
  static const queueTimeline = "queueTimeline";
  static const item = "item";
  static const topMatch = "topMatch";
  static const baseRank = "baseRank";

  static const allBoxes = [
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
    baseRank,
  ];
}

enum RecordExpiryName {
  champion,
  searchHistory,
  playerChampion,
  queueTimeline,
  item,
  topMatch,
  baseRank,
}

abstract class RecordExpiryDuration {
  // Time to live duration of these records
  static const championDuration = Duration(days: 1);
  static const searchHistoryDuration = Duration(hours: 1);
  static const playerChampionDuration = Duration(days: 1);
  static const queueTimelineDuration = Duration(minutes: 30);
  static const itemDuration = Duration(days: 1);
  static const topMatchDuration = Duration(hours: 6);
  static const baseRankDuration = Duration(days: 1);
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
  static const baseRank = 18;
}

abstract class StorageKeys {
  static const token = "token";
}
