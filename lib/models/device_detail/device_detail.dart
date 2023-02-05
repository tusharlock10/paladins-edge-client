import "package:json_annotation/json_annotation.dart";

part "device_detail.g.dart";

@JsonSerializable()
class DeviceDetail {
  final String platform;
  final Map<String, dynamic>? androidDevice;
  final Map<String, dynamic>? webDevice;

  DeviceDetail({
    required this.platform,
    this.androidDevice,
    this.webDevice,
  });

  factory DeviceDetail.fromJson(Map<String, dynamic> json) =>
      _$DeviceDetailFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceDetailToJson(this);
}
