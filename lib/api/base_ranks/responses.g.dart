// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRankResponse _$BaseRankResponseFromJson(Map<String, dynamic> json) =>
    BaseRankResponse(
      ranks: (json['ranks'] as List<dynamic>)
          .map((e) => BaseRank.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BaseRankResponseToJson(BaseRankResponse instance) =>
    <String, dynamic>{
      'ranks': instance.ranks,
    };
