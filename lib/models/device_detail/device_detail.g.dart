// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceDetail _$DeviceDetailFromJson(Map<String, dynamic> json) => DeviceDetail(
      platform: json['platform'] as String,
      androidDevice: json['androidDevice'] as Map<String, dynamic>?,
      webDevice: json['webDevice'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$DeviceDetailToJson(DeviceDetail instance) =>
    <String, dynamic>{
      'platform': instance.platform,
      'androidDevice': instance.androidDevice,
      'webDevice': instance.webDevice,
    };
