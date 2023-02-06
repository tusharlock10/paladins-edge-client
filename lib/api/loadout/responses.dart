import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/models/index.dart" show Loadout;

part "responses.g.dart";

@JsonSerializable()
class PlayerLoadoutsResponse {
  final bool success;
  final String? error;
  final List<Loadout>? data;

  PlayerLoadoutsResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory PlayerLoadoutsResponse.fromJson(Map<String, dynamic> json) =>
      _$PlayerLoadoutsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerLoadoutsResponseToJson(this);
}

@JsonSerializable()
class CreateLoadoutResponse {
  final bool success;
  final String? error;
  final Loadout? data;

  CreateLoadoutResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory CreateLoadoutResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateLoadoutResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CreateLoadoutResponseToJson(this);
}

@JsonSerializable()
class DeleteLoadoutResponse {
  final bool success;
  final String? error;
  final bool? data;

  DeleteLoadoutResponse({
    this.success = false,
    this.error,
    this.data,
  });

  factory DeleteLoadoutResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteLoadoutResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteLoadoutResponseToJson(this);
}
