// The match that is completed

import "package:hive/hive.dart";
import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/constants/index.dart" show TypeIds;
import "package:paladinsedge/models/player/player.dart" show Ranked;

part "match.g.dart";

@JsonSerializable()
class MatchPlayerStats {
  /// number of kills the player got in match
  final num kills;

  /// number of assists the player got in match
  final num assists;

  /// number of deaths the player got in match
  final num deaths;

  /// damage dealt by the player with weapon
  final num weaponDamageDealt;

  /// total damage dealt by the player
  final num totalDamageDealt;

  /// damage blocked by the player through shields
  final num damageShielded;

  /// total damage taken by the player
  final num totalDamageTaken;

  /// healing done by the player for himself
  final num selfHealingDone;

  /// healing done by the player on allies
  final num healingDone;

  /// longest kill streak of the player
  final num biggestKillStreak;

  /// total number of multi kills of the player
  final num totalMultiKills;

  /// time spent on objective
  final num objectiveTime;

  /// credits earned by the player
  final num creditsEarned;

  /// KDA of the player
  double get kda => deaths == 0 ? -1 : (kills + assists) / deaths;

  /// KDA formatted into a string
  String get kdaFormatted => kda == -1
      ? "PR"
      : kda
          .toStringAsPrecision(kda < 1 ? 1 : kda.toInt().toString().length + 1);

  MatchPlayerStats({
    required this.kills,
    required this.assists,
    required this.deaths,
    required this.weaponDamageDealt,
    required this.totalDamageDealt,
    required this.damageShielded,
    required this.totalDamageTaken,
    required this.selfHealingDone,
    required this.healingDone,
    required this.biggestKillStreak,
    required this.totalMultiKills,
    required this.objectiveTime,
    required this.creditsEarned,
  });

  factory MatchPlayerStats.fromJson(Map<String, dynamic> json) =>
      _$MatchPlayerStatsFromJson(json);
  Map<String, dynamic> toJson() => _$MatchPlayerStatsToJson(this);
}

@JsonSerializable()
class MatchPlayerItem {
  final int itemId; // item id as per paladins api
  final int itemLevel; // level of item bought by the player in game

  MatchPlayerItem({
    required this.itemId,
    required this.itemLevel,
  });

  factory MatchPlayerItem.fromJson(Map<String, dynamic> json) =>
      _$MatchPlayerItemFromJson(json);
  Map<String, dynamic> toJson() => _$MatchPlayerItemToJson(this);
}

@JsonSerializable()
class MatchPlayerChampionCard {
  final int cardId2; // card id as per paladins getItems api
  final int cardLevel; // level of card used in the champion loadout

  MatchPlayerChampionCard({
    required this.cardId2,
    required this.cardLevel,
  });

  factory MatchPlayerChampionCard.fromJson(Map<String, dynamic> json) =>
      _$MatchPlayerChampionCardFromJson(json);
  Map<String, dynamic> toJson() => _$MatchPlayerChampionCardToJson(this);
}

@JsonSerializable()
class MatchPlayer {
  /// player id as per paladins api
  final String playerId;

  /// name of the player
  final String playerName;

  /// id of the match it is connected to
  final String matchId;

  /// champion id as per paladins api
  final int championId;

  /// talent used for the champion, id as per paladins getItems api
  final int talentId2;

  /// skin of the champion
  final String skin;

  /// skin id as per paladins api
  final int skinId;

  /// party the player belongs to
  final int? partyNumber;

  /// team of the player
  final int team;

  /// ranking of the player among other 9 players in that match
  final int? matchPosition;

  /// ranked details of the player for this match
  final Ranked? playerRanked;

  /// stats of the player
  final MatchPlayerStats playerStats;

  /// items bought by the player
  final List<MatchPlayerItem> playerItems;

  /// champion cards used by the player
  final List<MatchPlayerChampionCard> playerChampionCards;

  /// If the matchPlayer data is in complete or not
  // needs a paladinsAPI call to fetch the complete data
  // most matchPlayers will be inComplete by default
  // and matchDetail api needs to be called to complete the data
  // _matchId will be null for inComplete matchPlayers
  // partyId will be 0 for inComplete matchPlayers
  final bool isInComplete;

  // was the player a bot during this match
  final bool isBot;

  MatchPlayer({
    required this.playerId,
    required this.playerName,
    required this.matchId,
    required this.championId,
    required this.talentId2,
    required this.skin,
    required this.skinId,
    required this.partyNumber,
    required this.team,
    this.matchPosition,
    this.playerRanked,
    required this.playerStats,
    required this.playerItems,
    required this.playerChampionCards,
    required this.isInComplete,
    required this.isBot,
  });

  factory MatchPlayer.fromJson(Map<String, dynamic> json) =>
      _$MatchPlayerFromJson(json);
  Map<String, dynamic> toJson() => _$MatchPlayerToJson(this);
}

@JsonSerializable()
class Match {
  /// id of the match
  final String matchId;

  /// team that won the match
  final int winningTeam;

  /// score of team 1
  final int team1Score;

  /// score of team 2
  final int team2Score;

  /// time when the match started
  final DateTime matchStartTime;

  /// duration of the match
  final int matchDuration;

  /// queue of the match
  final String queue;

  /// map of the match
  final String map;

  /// region of the match
  final String region;

  /// is this match a Ranked match
  final bool isRankedMatch;

  /// id champion that were banned in the match
  final List<int> championBans;

  /// If the match data is in complete or not
  // if the match has inComplete data, and needs a paladinsAPI call to fetch the complete data
  // most matches will be inComplete by default
  // and matchDetail api needs to be called to complete the data
  // championBans will be empty for inComplete matches
  final bool isInComplete;

  Match({
    required this.matchId,
    required this.winningTeam,
    required this.team1Score,
    required this.team2Score,
    required this.matchStartTime,
    required this.matchDuration,
    required this.queue,
    required this.map,
    required this.region,
    required this.isRankedMatch,
    required this.championBans,
    required this.isInComplete,
  });

  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);
  Map<String, dynamic> toJson() => _$MatchToJson(this);
}

@HiveType(typeId: TypeIds.topMatch)
@JsonSerializable()
class TopMatch {
  /// id of the top match
  @HiveField(0)
  final String matchId;

  /// type of to match
  @HiveField(1)
  final String type;

  /// value to show for this top match
  @HiveField(2)
  final int value;

  /// name of the player for this record
  @HiveField(3)
  final String? playerName;

  /// id of the player for this record
  @HiveField(4)
  final String? playerId;

  TopMatch({
    required this.matchId,
    required this.type,
    required this.value,
    required this.playerName,
    required this.playerId,
  });

  factory TopMatch.fromJson(Map<String, dynamic> json) =>
      _$TopMatchFromJson(json);
  Map<String, dynamic> toJson() => _$TopMatchToJson(this);
}
