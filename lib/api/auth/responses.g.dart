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

DeviceDetailResponse _$DeviceDetailResponseFromJson(
        Map<String, dynamic> json) =>
    DeviceDetailResponse(
      success: json['success'] as bool? ?? false,
      error: json['error'] as String?,
      data: json['data'] == null
          ? null
          : DeviceDetail.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeviceDetailResponseToJson(
        DeviceDetailResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
      'data': instance.data,
    };

ApiStatusResponse _$ApiStatusResponseFromJson(Map<String, dynamic> json) =>
    ApiStatusResponse(
      apiAvailable: json['apiAvailable'] as bool,
    );

Map<String, dynamic> _$ApiStatusResponseToJson(ApiStatusResponse instance) =>
    <String, dynamic>{
      'apiAvailable': instance.apiAvailable,
    };
