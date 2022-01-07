// The match that is completed

import 'package:json_annotation/json_annotation.dart';
import 'package:paladinsedge/models/player/player.dart' show Ranked;

part 'match.g.dart';

@JsonSerializable()
class MatchPlayerStats {
  /// number of kills the player got in match
  final int kills;

  /// number of assists the player got in match
  final int assists;

  /// number of deaths the player got in match
  final int deaths;

  /// damage dealt by the player with weapon
  final int weaponDamageDealt;

  /// total damage dealt by the player
  final int totalDamageDealt;

  /// damage blocked by the player through shields
  final int damageShielded;

  /// total damage taken by the player
  final int totalDamageTaken;

  /// healing done by the player for himself
  final int selfHealingDone;

  /// healing done by the player on allies
  final int healingDone;

  /// longest kill streak of the player
  final int biggestKillStreak;

  /// total number of multi kills of the player
  final int totalMultiKills;

  /// time spent on objective
  final int objectiveTime;

  /// credits earned by the player
  final int creditsEarned;

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
class MatchPlayerItems {
  final int itemId; // item id as per paladins api
  final int itemLevel; // level of item bought by the player in game

  MatchPlayerItems({
    required this.itemId,
    required this.itemLevel,
  });

  factory MatchPlayerItems.fromJson(Map<String, dynamic> json) =>
      _$MatchPlayerItemsFromJson(json);
  Map<String, dynamic> toJson() => _$MatchPlayerItemsToJson(this);
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
  final int partyId;

  /// team of the player
  final int team;

  /// ranking of the player among other 9 players in that match
  final int? matchPosition;

  /// ranked details of the player for this match
  final Ranked? playerRanked;

  /// stats of the player
  final MatchPlayerStats playerStats;

  /// items bought by the player
  final List<MatchPlayerItems> playerItems;

  /// champion cards used by the player
  final List<MatchPlayerChampionCard> playerChampionCards;

  /// If the matchPlayer data is in complete or not
  // needs a paladinsAPI call to fetch the complete data
  // most matchPlayers will be inComplete by default
  // and matchDetail api needs to be called to complete the data
  // _matchId will be null for inComplete matchPlayers
  // partyId will be 0 for inComplete matchPlayers
  final bool isInComplete;

  MatchPlayer({
    required this.playerId,
    required this.playerName,
    required this.matchId,
    required this.championId,
    required this.talentId2,
    required this.skin,
    required this.skinId,
    required this.partyId,
    required this.team,
    this.matchPosition,
    this.playerRanked,
    required this.playerStats,
    required this.playerItems,
    required this.playerChampionCards,
    required this.isInComplete,
  });

  factory MatchPlayer.fromJson(Map<String, dynamic> json) =>
      _$MatchPlayerFromJson(json);
  Map<String, dynamic> toJson() => _$MatchPlayerToJson(this);
}

@JsonSerializable()
class Match {
  /// id of the match
  final String matchId;

  /// player ids stored in a list, for easier searching of the match in db
  final List<String> playerIds;

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
  // playerIds & _playerIds & championBans will be empty for inComplete matches
  final bool isInComplete;

  Match({
    required this.matchId,
    required this.playerIds,
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
