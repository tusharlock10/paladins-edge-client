// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderboardPlayerResponse _$LeaderboardPlayerResponseFromJson(
        Map<String, dynamic> json) =>
    LeaderboardPlayerResponse(
      leaderboardPlayers: (json['leaderboardPlayers'] as List<dynamic>)
          .map((e) => LeaderboardPlayer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LeaderboardPlayerResponseToJson(
        LeaderboardPlayerResponse instance) =>
    <String, dynamic>{
      'leaderboardPlayers': instance.leaderboardPlayers,
    };
