import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paladinsedge/constants.dart' show TypeIds;
import 'package:paladinsedge/utilities/index.dart' as utilities;

part 'player.g.dart';

@HiveType(typeId: TypeIds.playerRanked)
@JsonSerializable()
class Ranked {
  @HiveField(0)
  final int? wins; // number of wins in ranked
  @HiveField(1)
  final int? looses; // number of losses in ranked
  @HiveField(2)
  final int?
      rank; // the rank of the player in number in numbers eg. 1 if bronze 5
  @HiveField(3)
  final String? rankName; // the rank of the player in string eg. Master
  @HiveField(4)
  final String? rankIconUrl; // image url of the rank icon
  @HiveField(5)
  final int? points; // the tp of the player at the current ranks

  Ranked({
    required this.wins,
    required this.looses,
    required this.rank,
    required this.rankName,
    required String? rankIconUrl,
    required this.points,
  }) : rankIconUrl = utilities.getUrlFromKey(rankIconUrl);

  factory Ranked.fromJson(Map<String, dynamic> json) => _$RankedFromJson(json);
  Map<String, dynamic> toJson() => _$RankedToJson(this);
}

@HiveType(typeId: TypeIds.player)
@JsonSerializable()
class Player {
  @HiveField(0)
  final String playerId; // paladins player id
  @HiveField(1)
  final String? userId; // id of the connected user model
  @HiveField(2)
  final String name; // name of the player in the game eg. tusharlock10
  @HiveField(3)
  final String? title; // Paladins title that appears below name eg. The 1%
  @HiveField(4)
  final String? avatarUrl; // image url of the avatar
  @HiveField(5)
  final int? totalXP; // total exp the player has

  @HiveField(6)
  final int? hoursPlayed; // amount of hours the player has played
  @HiveField(7)
  final int? level; // Level of the player in the game
  @HiveField(8)
  final int? totalWins; // number of total wins in paladins
  @HiveField(9)
  final int? totalLosses; // number of total losses in paladins
  @HiveField(10)
  final String? platform; // at which platform is he playing eg. Steam
  @HiveField(11)
  final String? region; // from which region the player is eg. Europe

  @HiveField(12)
  final DateTime?
      accountCreationDate; // the date at which the user created his paladins account
  @HiveField(13)
  final DateTime? lastLoginDate; // the date at which the user logged in last

  @HiveField(14)
  final Ranked ranked; // ranked details of the player
  @HiveField(15)
  final String? status; // if the player is Offline, In Match, etc

  @HiveField(16)
  final List<String>? friends; // list of playerId of the friends

  Player({
    required this.playerId,
    this.userId,
    required this.name,
    required this.title,
    required String? avatarUrl,
    required this.totalXP,
    required this.hoursPlayed,
    required this.level,
    required this.totalWins,
    required this.totalLosses,
    required this.platform,
    required this.region,
    required this.accountCreationDate,
    required this.lastLoginDate,
    required this.ranked,
    this.status,
    this.friends,
  }) : avatarUrl = utilities.getUrlFromKey(avatarUrl);

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
