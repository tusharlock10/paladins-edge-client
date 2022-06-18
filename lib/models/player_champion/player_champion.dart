import "package:hive/hive.dart";
import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/constants.dart" show TypeIds;

part "player_champion.g.dart";

/// Stores stats for a champion played by the player
@HiveType(typeId: TypeIds.playerChampion)
@JsonSerializable()
class PlayerChampion {
  /// Paladins playerId to which this champion data belong
  @HiveField(0)
  final String playerId;

  /// Paladins champion id
  @HiveField(1)
  final int championId;

  /// total number of eliminations
  @HiveField(2)
  final int totalAssists;

  /// total death playing this champion
  @HiveField(3)
  final int totalDeaths;

  /// total credits earned playing this champion
  @HiveField(4)
  final int totalCredits;

  /// total number of kills
  @HiveField(5)
  final int totalKills;

  /// date last played this champion
  @HiveField(6)
  final DateTime lastPlayed;

  /// number of matches lost
  @HiveField(7)
  final int losses;

  /// number of matches won
  @HiveField(8)
  final int wins;

  /// play time for that champion in minutes
  @HiveField(9)
  final int playTime;

  /// level of that champion
  @HiveField(10)
  final int level;

  /// total XP of the player with that champion
  @HiveField(11)
  final int totalXP;

  /// KDA of the player on this champion
  double get kda =>
      totalDeaths == 0 ? -1 : (totalKills + totalAssists) / totalDeaths;

  /// KDA formatted into a string
  String get kdaFormatted => kda == -1 ? "Perfect" : kda.toStringAsPrecision(3);

  // total matches played on this champion
  int get matches => wins + losses;

  /// win rate of the player on this champion (0 to 1)
  double? get winRate => matches == 0 ? null : wins / matches;

  /// win rate formatted into a string
  String? get winRateFormatted =>
      winRate == null ? null : (winRate! * 100).toStringAsPrecision(3);

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
