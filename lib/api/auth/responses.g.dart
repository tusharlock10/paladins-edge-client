// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] == null
          ? null
          : LoginData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

LogoutResponse _$LogoutResponseFromJson(Map<String, dynamic> json) =>
    LogoutResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] as bool?,
    );

Map<String, dynamic> _$LogoutResponseToJson(LogoutResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

CheckPlayerClaimedResponse _$CheckPlayerClaimedResponseFromJson(
        Map<String, dynamic> json) =>
    CheckPlayerClaimedResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] as bool?,
    );

Map<String, dynamic> _$CheckPlayerClaimedResponseToJson(
        CheckPlayerClaimedResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

ClaimPlayerResponse _$ClaimPlayerResponseFromJson(Map<String, dynamic> json) =>
    ClaimPlayerResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] == null
          ? null
          : ClaimPlayerData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClaimPlayerResponseToJson(
        ClaimPlayerResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

FaqsResponse _$FaqsResponseFromJson(Map<String, dynamic> json) => FaqsResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FAQ.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FaqsResponseToJson(FaqsResponse instance) =>
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

DeviceDetailResponse _$DeviceDetailResponseFromJson(
        Map<String, dynamic> json) =>
    DeviceDetailResponse(
      deviceDetail:
          DeviceDetail.fromJson(json['deviceDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeviceDetailResponseToJson(
        DeviceDetailResponse instance) =>
    <String, dynamic>{
      'deviceDetail': instance.deviceDetail,
    };

ApiStatusResponse _$ApiStatusResponseFromJson(Map<String, dynamic> json) =>
    ApiStatusResponse(
      apiAvailable: json['apiAvailable'] as bool,
    );

Map<String, dynamic> _$ApiStatusResponseToJson(ApiStatusResponse instance) =>
    <String, dynamic>{
      'apiAvailable': instance.apiAvailable,
    };
