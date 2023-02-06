// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchData _$MatchDataFromJson(Map<String, dynamic> json) => MatchData(
      match: Match.fromJson(json['match'] as Map<String, dynamic>),
      matchPlayers: (json['matchPlayers'] as List<dynamic>)
          .map((e) => MatchPlayer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MatchDataToJson(MatchData instance) => <String, dynamic>{
      'match': instance.match,
      'matchPlayers': instance.matchPlayers,
    };

MatchesData _$MatchesDataFromJson(Map<String, dynamic> json) => MatchesData(
      matches: (json['matches'] as List<dynamic>)
          .map((e) => Match.fromJson(e as Map<String, dynamic>))
          .toList(),
      matchPlayers: (json['matchPlayers'] as List<dynamic>)
          .map((e) => MatchPlayer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MatchesDataToJson(MatchesData instance) =>
    <String, dynamic>{
      'matches': instance.matches,
      'matchPlayers': instance.matchPlayers,
    };
