// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchDetailsResponse _$MatchDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    MatchDetailsResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] == null
          ? null
          : MatchData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MatchDetailsResponseToJson(
        MatchDetailsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

PlayerMatchesResponse _$PlayerMatchesResponseFromJson(
        Map<String, dynamic> json) =>
    PlayerMatchesResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] == null
          ? null
          : MatchesData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerMatchesResponseToJson(
        PlayerMatchesResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

SavedMatchesResponse _$SavedMatchesResponseFromJson(
        Map<String, dynamic> json) =>
    SavedMatchesResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] == null
          ? null
          : MatchesData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SavedMatchesResponseToJson(
        SavedMatchesResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

UpdateSavedMatchesResponse _$UpdateSavedMatchesResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateSavedMatchesResponse(
      savedMatches: (json['savedMatches'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UpdateSavedMatchesResponseToJson(
        UpdateSavedMatchesResponse instance) =>
    <String, dynamic>{
      'savedMatches': instance.savedMatches,
    };

SaveMatchResponse _$SaveMatchResponseFromJson(Map<String, dynamic> json) =>
    SaveMatchResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$SaveMatchResponseToJson(SaveMatchResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

CommonMatchesResponse _$CommonMatchesResponseFromJson(
        Map<String, dynamic> json) =>
    CommonMatchesResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] == null
          ? null
          : MatchesData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommonMatchesResponseToJson(
        CommonMatchesResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

TopMatchesResponse _$TopMatchesResponseFromJson(Map<String, dynamic> json) =>
    TopMatchesResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TopMatch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopMatchesResponseToJson(TopMatchesResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };
