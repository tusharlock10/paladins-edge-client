// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'champions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BatchPlayerChampionsPayload _$BatchPlayerChampionsPayloadFromJson(
        Map<String, dynamic> json) =>
    BatchPlayerChampionsPayload(
      playerId: json['playerId'] as String,
      championId: json['championId'] as String,
    );

Map<String, dynamic> _$BatchPlayerChampionsPayloadToJson(
        BatchPlayerChampionsPayload instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'championId': instance.championId,
    };
