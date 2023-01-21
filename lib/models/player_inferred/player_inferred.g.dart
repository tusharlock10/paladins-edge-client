// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_inferred.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicPlayer _$BasicPlayerFromJson(Map<String, dynamic> json) => BasicPlayer(
      playerId: json['playerId'] as int,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String,
      avatarBlurHash: json['avatarBlurHash'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$BasicPlayerToJson(BasicPlayer instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'name': instance.name,
      'title': instance.title,
      'avatarUrl': instance.avatarUrl,
      'avatarBlurHash': instance.avatarBlurHash,
    };

PlayerInferred _$PlayerInferredFromJson(Map<String, dynamic> json) =>
    PlayerInferred(
      playerId: json['playerId'] as int,
      recentlyPlayedChampions:
          (json['recentlyPlayedChampions'] as List<dynamic>)
              .map((e) => e as int)
              .toList(),
      recentlyPlayedQueues: (json['recentlyPlayedQueues'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      recentPartyMembers: (json['recentPartyMembers'] as List<dynamic>)
          .map((e) => BasicPlayer.fromJson(e as Map<String, dynamic>))
          .toList(),
      averageStats: MatchPlayerStats.fromJson(
          json['averageStats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerInferredToJson(PlayerInferred instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'recentlyPlayedChampions': instance.recentlyPlayedChampions,
      'recentlyPlayedQueues': instance.recentlyPlayedQueues,
      'recentPartyMembers': instance.recentPartyMembers,
      'averageStats': instance.averageStats,
    };
