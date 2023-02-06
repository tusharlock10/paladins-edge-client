// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerLoadoutsResponse _$PlayerLoadoutsResponseFromJson(
        Map<String, dynamic> json) =>
    PlayerLoadoutsResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Loadout.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlayerLoadoutsResponseToJson(
        PlayerLoadoutsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

CreateLoadoutResponse _$CreateLoadoutResponseFromJson(
        Map<String, dynamic> json) =>
    CreateLoadoutResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] == null
          ? null
          : Loadout.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateLoadoutResponseToJson(
        CreateLoadoutResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

DeleteLoadoutResponse _$DeleteLoadoutResponseFromJson(
        Map<String, dynamic> json) =>
    DeleteLoadoutResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] as bool?,
    );

Map<String, dynamic> _$DeleteLoadoutResponseToJson(
        DeleteLoadoutResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };
