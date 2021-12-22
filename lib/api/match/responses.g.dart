// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchDetailsResponse _$MatchDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    MatchDetailsResponse(
      match: Match.fromJson(json['match'] as Map<String, dynamic>),
      matchPlayers: (json['matchPlayers'] as List<dynamic>)
          .map((e) => MatchPlayer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MatchDetailsResponseToJson(
        MatchDetailsResponse instance) =>
    <String, dynamic>{
      'match': instance.match,
      'matchPlayers': instance.matchPlayers,
    };

PlayerMatchesResponse _$PlayerMatchesResponseFromJson(
        Map<String, dynamic> json) =>
    PlayerMatchesResponse(
      matches: (json['matches'] as List<dynamic>)
          .map((e) => Match.fromJson(e as Map<String, dynamic>))
          .toList(),
      matchPlayers: (json['matchPlayers'] as List<dynamic>)
          .map((e) => MatchPlayer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlayerMatchesResponseToJson(
        PlayerMatchesResponse instance) =>
    <String, dynamic>{
      'matches': instance.matches,
      'matchPlayers': instance.matchPlayers,
    };
