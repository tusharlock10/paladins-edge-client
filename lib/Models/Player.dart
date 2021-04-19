import 'package:json_annotation/json_annotation.dart';
part 'Player.g.dart';

@JsonSerializable()
class _Ranked {
  final int? wins; // number of wins in ranked
  final int? looses; // number of losses in ranked
  final int?
      rank; // the rank of the player in number in numbers eg. 1 if bronze 5
  final String? rankName; // the rank of the player in string eg. Master
  final String? rankIconUrl; // image url of the rank icon
  final int? points; // the tp of the player at the current ranks

  _Ranked({
    required this.wins,
    required this.looses,
    required this.rank,
    required this.rankName,
    required this.rankIconUrl,
    required this.points,
  });

  factory _Ranked.fromJson(Map<String, dynamic> json) =>
      _$_RankedFromJson(json);
  Map<String, dynamic> toJson() => _$_RankedToJson(this);
}

@JsonSerializable()
class Player {
  final String name; // name of the player in the game eg. tusharlock10
  final String? title; // Paladins title that appears below name eg. The 1%
  final int playerId; // paladins Id of the player
  final String? avatarUrl; // image url of the avatar
  final int? totalXP;

  final int? hoursPlayed;
  final int? level; // Level of the player in the game
  final int? totalWins; // number of total wins in paladins
  final int? totalLosses; // number of total losses in paladins
  final String? platform; // at which platform is he playing eg. Steam
  final String? region; // from which region the player is eg. Europe

  final DateTime?
      accountCreationDate; // the date at which the user created his paladins account
  final DateTime? lastLoginDate; // the date at which the user logged in last

  final _Ranked ranked; // ranked details of the player

  Player({
    required this.name,
    required this.title,
    required this.playerId,
    required this.avatarUrl,
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
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerToJson(this);
}
