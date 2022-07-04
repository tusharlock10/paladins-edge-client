// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceDetail _$DeviceDetailFromJson(Map<String, dynamic> json) => DeviceDetail(
      platform: json['platform'] as String,
      androidDeviceInfo: json['androidDeviceInfo'] as Map<String, dynamic>?,
      webDeviceInfo: json['webDeviceInfo'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$DeviceDetailToJson(DeviceDetail instance) =>
    <String, dynamic>{
      'platform': instance.platform,
      'androidDeviceInfo': instance.androidDeviceInfo,
      'webDeviceInfo': instance.webDeviceInfo,
    };
