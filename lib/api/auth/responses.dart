import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/data_classes/index.dart"
    show LoginData, ClaimPlayerData;
import "package:paladinsedge/models/index.dart" show DeviceDetail;

part "responses.g.dart";

@JsonSerializable()
class LoginResponse {
  final bool success;
  final String? error;
  final LoginData? data;

  LoginResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class LogoutResponse {
  final bool success;
  final String? error;
  final bool? data;

  LogoutResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory LogoutResponse.fromJson(Map<String, dynamic> json) =>
      _$LogoutResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LogoutResponseToJson(this);
}

@JsonSerializable()
class CheckPlayerClaimedResponse {
  final bool success;
  final String? error;
  final bool? data;

  CheckPlayerClaimedResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory CheckPlayerClaimedResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckPlayerClaimedResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CheckPlayerClaimedResponseToJson(this);
}

@JsonSerializable()
class ClaimPlayerResponse {
  final bool success;
  final String? error;
  final ClaimPlayerData? data;

  ClaimPlayerResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory ClaimPlayerResponse.fromJson(Map<String, dynamic> json) =>
      _$ClaimPlayerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ClaimPlayerResponseToJson(this);
}

@JsonSerializable()
class DeviceDetailResponse {
  final bool success;
  final String? error;
  final DeviceDetail? data;

  DeviceDetailResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory DeviceDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceDetailResponseToJson(this);
}

@JsonSerializable()
class ApiStatusResponse {
  final bool apiAvailable;

  ApiStatusResponse({
    required this.apiAvailable,
  });

  factory ApiStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiStatusResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiStatusResponseToJson(this);
}
