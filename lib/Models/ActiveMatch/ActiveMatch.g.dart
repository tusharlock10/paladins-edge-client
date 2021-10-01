// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ActiveMatch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveMatch _$ActiveMatchFromJson(Map<String, dynamic> json) => ActiveMatch(
      matchId: json['matchId'] as int,
      queue: json['queue'] as String,
      map: json['map'] as String,
      region: json['region'] as String,
      playersInfo: (json['playersInfo'] as List<dynamic>)
          .map(
              (e) => ActiveMatchPlayersInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ActiveMatchToJson(ActiveMatch instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'queue': instance.queue,
      'map': instance.map,
      'region': instance.region,
      'playersInfo': instance.playersInfo,
    };

ActiveMatchPlayersInfo _$ActiveMatchPlayersInfoFromJson(
        Map<String, dynamic> json) =>
    ActiveMatchPlayersInfo(
      player: ActiveMatchPlayerDetail.fromJson(
          json['player'] as Map<String, dynamic>),
      championId: json['championId'] as int,
      championLevel: json['championLevel'] as int,
      championName: json['championName'] as String,
    );

Map<String, dynamic> _$ActiveMatchPlayersInfoToJson(
        ActiveMatchPlayersInfo instance) =>
    <String, dynamic>{
      'player': instance.player,
      'championId': instance.championId,
      'championLevel': instance.championLevel,
      'championName': instance.championName,
    };

ActiveMatchPlayerDetail _$ActiveMatchPlayerDetailFromJson(
        Map<String, dynamic> json) =>
    ActiveMatchPlayerDetail(
      playerId: json['playerId'] as int,
      name: json['name'] as String,
      platform: json['platform'] as String,
      level: json['level'] as int,
    );

Map<String, dynamic> _$ActiveMatchPlayerDetailToJson(
        ActiveMatchPlayerDetail instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'name': instance.name,
      'platform': instance.platform,
      'level': instance.level,
    };
