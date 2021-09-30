// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlayerChampion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerChampion _$PlayerChampionFromJson(Map<String, dynamic> json) =>
    PlayerChampion(
      playerId: json['playerId'] as String,
      championId: json['championId'] as String,
      totalAssists: json['totalAssists'] as int,
      totalDeaths: json['totalDeaths'] as int,
      totalCredits: json['totalCredits'] as int,
      totalKills: json['totalKills'] as int,
      lastPlayed: DateTime.parse(json['lastPlayed'] as String),
      losses: json['losses'] as int,
      wins: json['wins'] as int,
      playTime: json['playTime'] as int,
      level: json['level'] as int,
      totalXP: json['totalXP'] as int,
    );

Map<String, dynamic> _$PlayerChampionToJson(PlayerChampion instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'championId': instance.championId,
      'totalAssists': instance.totalAssists,
      'totalDeaths': instance.totalDeaths,
      'totalCredits': instance.totalCredits,
      'totalKills': instance.totalKills,
      'lastPlayed': instance.lastPlayed.toIso8601String(),
      'losses': instance.losses,
      'wins': instance.wins,
      'playTime': instance.playTime,
      'level': instance.level,
      'totalXP': instance.totalXP,
    };
