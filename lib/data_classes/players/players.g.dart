// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LowerSearch _$LowerSearchFromJson(Map<String, dynamic> json) => LowerSearch(
      name: json['name'] as String,
      playerId: json['playerId'] as int,
      platform: json['platform'] as String,
    );

Map<String, dynamic> _$LowerSearchToJson(LowerSearch instance) =>
    <String, dynamic>{
      'name': instance.name,
      'playerId': instance.playerId,
      'platform': instance.platform,
    };

SearchPlayersData _$SearchPlayersDataFromJson(Map<String, dynamic> json) =>
    SearchPlayersData(
      topSearchPlayers: (json['topSearchPlayers'] as List<dynamic>)
          .map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
      lowerSearchPlayers: (json['lowerSearchPlayers'] as List<dynamic>)
          .map((e) => LowerSearch.fromJson(e as Map<String, dynamic>))
          .toList(),
      exactMatch: json['exactMatch'] as bool,
      player: json['player'] == null
          ? null
          : Player.fromJson(json['player'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchPlayersDataToJson(SearchPlayersData instance) =>
    <String, dynamic>{
      'topSearchPlayers': instance.topSearchPlayers,
      'lowerSearchPlayers': instance.lowerSearchPlayers,
      'exactMatch': instance.exactMatch,
      'player': instance.player,
    };

PlayerStatus _$PlayerStatusFromJson(Map<String, dynamic> json) => PlayerStatus(
      playerId: json['playerId'] as int,
      inMatch: json['inMatch'] as bool,
      status: json['status'] as String,
      match: json['match'] == null
          ? null
          : ActiveMatch.fromJson(json['match'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerStatusToJson(PlayerStatus instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'inMatch': instance.inMatch,
      'status': instance.status,
      'match': instance.match,
    };
