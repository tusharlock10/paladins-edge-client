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

SavePlayerLoadoutResponse _$SavePlayerLoadoutResponseFromJson(
        Map<String, dynamic> json) =>
    SavePlayerLoadoutResponse(
      loadout: Loadout.fromJson(json['loadout'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SavePlayerLoadoutResponseToJson(
        SavePlayerLoadoutResponse instance) =>
    <String, dynamic>{
      'loadout': instance.loadout,
    };
