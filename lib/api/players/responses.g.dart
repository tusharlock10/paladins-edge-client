// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchPlayersResponse _$SearchPlayersResponseFromJson(
        Map<String, dynamic> json) =>
    SearchPlayersResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] == null
          ? null
          : SearchPlayersData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchPlayersResponseToJson(
        SearchPlayersResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

PlayerDetailResponse _$PlayerDetailResponseFromJson(
        Map<String, dynamic> json) =>
    PlayerDetailResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] == null
          ? null
          : Player.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerDetailResponseToJson(
        PlayerDetailResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

BatchPlayerDetailsResponse _$BatchPlayerDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    BatchPlayerDetailsResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BatchPlayerDetailsResponseToJson(
        BatchPlayerDetailsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

PlayerStatusResponse _$PlayerStatusResponseFromJson(
        Map<String, dynamic> json) =>
    PlayerStatusResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] == null
          ? null
          : PlayerStatus.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerStatusResponseToJson(
        PlayerStatusResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

FriendsResponse _$FriendsResponseFromJson(Map<String, dynamic> json) =>
    FriendsResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FriendsResponseToJson(FriendsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

FavouriteFriendsResponse _$FavouriteFriendsResponseFromJson(
        Map<String, dynamic> json) =>
    FavouriteFriendsResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavouriteFriendsResponseToJson(
        FavouriteFriendsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

UpdateFavouriteFriendResponse _$UpdateFavouriteFriendResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateFavouriteFriendResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$UpdateFavouriteFriendResponseToJson(
        UpdateFavouriteFriendResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

SearchHistoryResponse _$SearchHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    SearchHistoryResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SearchHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchHistoryResponseToJson(
        SearchHistoryResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

PlayerInferredResponse _$PlayerInferredResponseFromJson(
        Map<String, dynamic> json) =>
    PlayerInferredResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] == null
          ? null
          : PlayerInferred.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerInferredResponseToJson(
        PlayerInferredResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };
