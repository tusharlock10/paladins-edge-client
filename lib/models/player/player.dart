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
  /// paladins player id
  @HiveField(0)
  final String playerId;

  /// id of the connected user model
  @HiveField(1)
  final String? userId;

  /// name of the player in the game eg. tusharlock10
  @HiveField(2)
  final String name;

  /// Paladins title that appears below name eg. The 1%
  @HiveField(3)
  final String? title;

  /// image url of the avatar
  @HiveField(4)
  final String? avatarUrl;

  /// total exp the player has
  @HiveField(5)
  final int? totalXP;

  /// amount of hours the player has played
  @HiveField(6)
  final int? hoursPlayed;

  /// Level of the player in the game
  @HiveField(7)
  final int? level;

  /// number of total wins in paladins
  @HiveField(8)
  final int? totalWins;

  /// number of total losses in paladins
  @HiveField(9)
  final int? totalLosses;

  /// at which platform is he playing eg. Steam
  @HiveField(10)
  final String? platform;

  /// from which region the player is eg. Europe
  @HiveField(11)
  final String? region;

  /// the date at which the user created his paladins account
  @HiveField(12)
  final DateTime? accountCreationDate;

  /// the date at which the user logged in last
  @HiveField(13)
  final DateTime? lastLoginDate;

  /// ranked details of the player
  @HiveField(14)
  final Ranked ranked;

  /// if the player is Offline, In Match, etc
  @HiveField(15)
  final String? status;

  /// list of playerId of the friends
  @HiveField(16)
  final List<String>? friends;

  /// last update date of friends
  @HiveField(17)
  final DateTime? lastUpdatedFriends;

  /// last update date of player profile
  @HiveField(18)
  final DateTime? lastUpdatedPlayer;

  /// last update date of player's matches
  @HiveField(19)
  final DateTime? lastUpdatedMatches;

  /// last update date of player's champion stats
  @HiveField(20)
  final DateTime? lastUpdatedChampions;

  Player({
    required this.playerId,
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
    this.userId,
    this.status,
    this.friends,
    this.lastUpdatedFriends,
    this.lastUpdatedPlayer,
    this.lastUpdatedMatches,
    this.lastUpdatedChampions,
  }) : avatarUrl = utilities.getUrlFromKey(avatarUrl);

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
