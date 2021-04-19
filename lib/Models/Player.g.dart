// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ranked _$_RankedFromJson(Map<String, dynamic> json) {
  return _Ranked(
    wins: json['wins'] as int?,
    looses: json['looses'] as int?,
    rank: json['rank'] as int?,
    rankName: json['rankName'] as String?,
    rankIconUrl: json['rankIconUrl'] as String?,
    points: json['points'] as int?,
  );
}

Map<String, dynamic> _$_RankedToJson(_Ranked instance) => <String, dynamic>{
      'wins': instance.wins,
      'looses': instance.looses,
      'rank': instance.rank,
      'rankName': instance.rankName,
      'rankIconUrl': instance.rankIconUrl,
      'points': instance.points,
    };

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return Player(
    name: json['name'] as String,
    title: json['title'] as String?,
    playerId: json['playerId'] as int,
    avatarUrl: json['avatarUrl'] as String?,
    totalXP: json['totalXP'] as int?,
    hoursPlayed: json['hoursPlayed'] as int?,
    level: json['level'] as int?,
    totalWins: json['totalWins'] as int?,
    totalLosses: json['totalLosses'] as int?,
    platform: json['platform'] as String?,
    region: json['region'] as String?,
    accountCreationDate: json['accountCreationDate'] == null
        ? null
        : DateTime.parse(json['accountCreationDate'] as String),
    lastLoginDate: json['lastLoginDate'] == null
        ? null
        : DateTime.parse(json['lastLoginDate'] as String),
    ranked: _Ranked.fromJson(json['ranked'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'playerId': instance.playerId,
      'avatarUrl': instance.avatarUrl,
      'totalXP': instance.totalXP,
      'hoursPlayed': instance.hoursPlayed,
      'level': instance.level,
      'totalWins': instance.totalWins,
      'totalLosses': instance.totalLosses,
      'platform': instance.platform,
      'region': instance.region,
      'accountCreationDate': instance.accountCreationDate?.toIso8601String(),
      'lastLoginDate': instance.lastLoginDate?.toIso8601String(),
      'ranked': instance.ranked,
    };
