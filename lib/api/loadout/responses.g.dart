// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerLoadoutsResponse _$PlayerLoadoutsResponseFromJson(
        Map<String, dynamic> json) =>
    PlayerLoadoutsResponse(
      loadouts: (json['loadouts'] as List<dynamic>)
          .map((e) => Loadout.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlayerLoadoutsResponseToJson(
        PlayerLoadoutsResponse instance) =>
    <String, dynamic>{
      'loadouts': instance.loadouts,
    };
