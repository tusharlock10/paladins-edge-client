// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderboardPlayer _$LeaderboardPlayerFromJson(Map<String, dynamic> json) =>
    LeaderboardPlayer(
      position: json['position'] as int,
      region: json['region'] as String,
      platform: json['platform'] as String,
      basicPlayer:
          BasicPlayer.fromJson(json['basicPlayer'] as Map<String, dynamic>),
      ranked: Ranked.fromJson(json['ranked'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LeaderboardPlayerToJson(LeaderboardPlayer instance) =>
    <String, dynamic>{
      'position': instance.position,
      'region': instance.region,
      'platform': instance.platform,
      'basicPlayer': instance.basicPlayer,
      'ranked': instance.ranked,
    };
