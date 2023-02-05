// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChampionsResponse _$ChampionsResponseFromJson(Map<String, dynamic> json) =>
    ChampionsResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Champion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChampionsResponseToJson(ChampionsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

PlayerChampionsResponse _$PlayerChampionsResponseFromJson(
        Map<String, dynamic> json) =>
    PlayerChampionsResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PlayerChampion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlayerChampionsResponseToJson(
        PlayerChampionsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

FavouriteChampionsResponse _$FavouriteChampionsResponseFromJson(
        Map<String, dynamic> json) =>
    FavouriteChampionsResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => e as int).toList(),
    );

Map<String, dynamic> _$FavouriteChampionsResponseToJson(
        FavouriteChampionsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

UpdateFavouriteChampionResponse _$UpdateFavouriteChampionResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateFavouriteChampionResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$UpdateFavouriteChampionResponseToJson(
        UpdateFavouriteChampionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };
