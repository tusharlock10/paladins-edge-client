import 'package:json_annotation/json_annotation.dart';

part 'player_champion.g.dart';

/// Stores stats for a champion played by the player
@JsonSerializable()
class PlayerChampion {
  /// Paladins playerId to which this champion data belong
  final String playerId;

  /// Paladins champion id
  final String championId;

  /// total number of eliminations
  final int totalAssists;

  /// total death playing this champion
  final int totalDeaths;

  /// total credits earned playing this champion
  final int totalCredits;

  /// total number of kills
  final int totalKills;

  /// date last played this champion
  final DateTime lastPlayed;

  /// number of matches lost
  final int losses;

  /// number of matches won
  final int wins;

  /// play time for that champion in minutes
  final int playTime;

  /// level of that champion
  final int level;

  /// total XP of the player with that champion
  final int totalXP;

  PlayerChampion({
    required this.playerId,
    required this.championId,
    required this.totalAssists,
    required this.totalDeaths,
    required this.totalCredits,
    required this.totalKills,
    required this.lastPlayed,
    required this.losses,
    required this.wins,
    required this.playTime,
    required this.level,
    required this.totalXP,
  });

  factory PlayerChampion.fromJson(Map<String, dynamic> json) =>
      _$PlayerChampionFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerChampionToJson(this);
}
