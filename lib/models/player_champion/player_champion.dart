import 'package:json_annotation/json_annotation.dart';

part 'player_champion.g.dart';

@JsonSerializable()
class PlayerChampion {
  final String playerId; // Paladins playerId to which this champion data belong
  final String championId; // Paladins champion id

  final int totalAssists; // total number of eliminations
  final int totalDeaths; // total death playing this champion
  final int totalCredits; // total credits earned playing this champion
  final int totalKills; // total number of kills

  final DateTime lastPlayed; // date last played this champion
  final int losses; // number of matches lost
  final int wins; // number of matches won
  final int playTime; // play time for that champion in minutes

  final int level; // level of that champion
  final int totalXP; // total XP of the player with that champion

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
