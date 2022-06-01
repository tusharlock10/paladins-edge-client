import "package:hive/hive.dart";
import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/constants.dart" show TypeIds;
import "package:paladinsedge/utilities/index.dart" as utilities;

part "player.g.dart";

@HiveType(typeId: TypeIds.playerRanked)
@JsonSerializable()
class Ranked {
  /// number of wins in ranked
  @HiveField(0)
  final int wins;

  /// number of losses in ranked
  @HiveField(1)
  final int looses;

  /// the rank of the player in number in numbers eg. 1 if bronze 5
  @HiveField(2)
  final int rank;

  /// the rank of the player in string eg. Master
  @HiveField(3)
  final String rankName;

  /// image url of the rank icon
  @HiveField(4)
  final String rankIconUrl;

  /// the tp of the player at the current ranks
  @HiveField(5)
  final int? points;

  Ranked({
    required this.wins,
    required this.looses,
    required this.rank,
    required this.rankName,
    required String rankIconUrl,
    this.points,
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
  final String avatarUrl;

  /// blur hash of the player avatar
  @HiveField(5)
  final String? avatarBlurHash;

  /// total exp the player has
  @HiveField(6)
  final int totalXP;

  /// amount of hours the player has played
  @HiveField(7)
  final int hoursPlayed;

  /// Level of the player in the game
  @HiveField(8)
  final int level;

  /// number of total wins in paladins
  @HiveField(9)
  final int totalWins;

  /// number of total losses in paladins
  @HiveField(10)
  final int totalLosses;

  /// at which platform is he playing eg. Steam
  @HiveField(11)
  final String platform;

  /// from which region the player is eg. Europe
  @HiveField(12)
  final String region;

  /// the date at which the user created his paladins account
  @HiveField(13)
  final DateTime accountCreationDate;

  /// the date at which the user logged in last
  @HiveField(14)
  final DateTime lastLoginDate;

  /// ranked details of the player
  @HiveField(15)
  final Ranked ranked;

  /// last update date of friends
  @HiveField(16)
  final DateTime? lastUpdatedFriends;

  /// last update date of player profile
  @HiveField(17)
  final DateTime? lastUpdatedPlayer;

  /// last update date of player's matches
  @HiveField(18)
  final DateTime? lastUpdatedMatches;

  /// last update date of player's champion stats
  @HiveField(19)
  final DateTime? lastUpdatedChampions;

  /// last update date of player's loadouts
  @HiveField(20)
  final DateTime? lastUpdatedLoadouts;

  Player({
    required this.playerId,
    required this.name,
    required String avatarUrl,
    required this.avatarBlurHash,
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
    this.title,
    this.lastUpdatedFriends,
    this.lastUpdatedPlayer,
    this.lastUpdatedMatches,
    this.lastUpdatedChampions,
    this.lastUpdatedLoadouts,
  }) : avatarUrl = utilities.getUrlFromKey(avatarUrl);

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}

@JsonSerializable()
class LowerSearchPlayer {
  /// paladins player id
  final String playerId;

  /// name of the player in the game eg. tusharlock10
  final String name;

  /// is the player profile private
  final bool isPrivate;

  /// at which platform is he playing eg. Steam
  final String platform;

  LowerSearchPlayer({
    required this.playerId,
    required this.name,
    required this.isPrivate,
    required this.platform,
  });

  factory LowerSearchPlayer.fromJson(Map<String, dynamic> json) =>
      _$LowerSearchPlayerFromJson(json);
  Map<String, dynamic> toJson() => _$LowerSearchPlayerToJson(this);
}
