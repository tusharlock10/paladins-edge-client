// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllChampionsResponse _$AllChampionsResponseFromJson(
        Map<String, dynamic> json) =>
    AllChampionsResponse(
      champions: (json['champions'] as List<dynamic>)
          .map((e) => Champion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllChampionsResponseToJson(
        AllChampionsResponse instance) =>
    <String, dynamic>{
      'champions': instance.champions,
    };

PlayerChampionsResponse _$PlayerChampionsResponseFromJson(
        Map<String, dynamic> json) =>
    PlayerChampionsResponse(
      playerChampions: (json['playerChampions'] as List<dynamic>)
          .map((e) => PlayerChampion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlayerChampionsResponseToJson(
        PlayerChampionsResponse instance) =>
    <String, dynamic>{
      'playerChampions': instance.playerChampions,
    };
