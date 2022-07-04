import "package:json_annotation/json_annotation.dart";

part "device_detail.g.dart";

@JsonSerializable()
class DeviceDetail {
  final String platform;
  final Map<String, dynamic>? androidDeviceInfo;
  final Map<String, dynamic>? webDeviceInfo;

  DeviceDetail({
    required this.platform,
    this.androidDeviceInfo,
    this.webDeviceInfo,
  });

  factory DeviceDetail.fromJson(Map<String, dynamic> json) =>
      _$DeviceDetailFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceDetailToJson(this);
}
