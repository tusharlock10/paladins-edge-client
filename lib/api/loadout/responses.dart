import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/models/index.dart" show Loadout;

part "responses.g.dart";

@JsonSerializable()
class PlayerLoadoutsResponse {
  final List<Loadout> loadouts;

  PlayerLoadoutsResponse({required this.loadouts});

  factory PlayerLoadoutsResponse.fromJson(Map<String, dynamic> json) =>
      _$PlayerLoadoutsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerLoadoutsResponseToJson(this);
}

@JsonSerializable()
class SavePlayerLoadoutResponse {
  final Loadout loadout;

  SavePlayerLoadoutResponse({required this.loadout});

  factory SavePlayerLoadoutResponse.fromJson(Map<String, dynamic> json) =>
      _$SavePlayerLoadoutResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SavePlayerLoadoutResponseToJson(this);
}

@JsonSerializable()
class DeletePlayerLoadoutResponse {
  final Loadout loadout;

  DeletePlayerLoadoutResponse({required this.loadout});

  factory DeletePlayerLoadoutResponse.fromJson(Map<String, dynamic> json) =>
      _$DeletePlayerLoadoutResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeletePlayerLoadoutResponseToJson(this);
}
