import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/data_classes/index.dart" show LoginData;
import "package:paladinsedge/models/index.dart"
    show User, Player, FAQ, Match, MatchPlayer, DeviceDetail;

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
class CheckPlayerClaimedResponse {
  final bool exists;

  CheckPlayerClaimedResponse({
    required this.exists,
  });

  factory CheckPlayerClaimedResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckPlayerClaimedResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CheckPlayerClaimedResponseToJson(this);
}

@JsonSerializable()
class ClaimPlayerResponse {
  final bool verified;
  final User? user;
  final Player? player;
  final String? reason;

  ClaimPlayerResponse({
    required this.verified,
    this.user,
    this.player,
    this.reason,
  });

  factory ClaimPlayerResponse.fromJson(Map<String, dynamic> json) =>
      _$ClaimPlayerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ClaimPlayerResponseToJson(this);
}

@JsonSerializable()
class FaqsResponse {
  final List<FAQ> faqs;

  FaqsResponse({
    required this.faqs,
  });

  factory FaqsResponse.fromJson(Map<String, dynamic> json) =>
      _$FaqsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FaqsResponseToJson(this);
}

@JsonSerializable()
class SavedMatchesResponse {
  final List<Match> matches;
  final List<MatchPlayer> matchPlayers;

  SavedMatchesResponse({
    required this.matches,
    required this.matchPlayers,
  });

  factory SavedMatchesResponse.fromJson(Map<String, dynamic> json) =>
      _$SavedMatchesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SavedMatchesResponseToJson(this);
}

@JsonSerializable()
class UpdateSavedMatchesResponse {
  final List<String> savedMatches;

  UpdateSavedMatchesResponse({
    required this.savedMatches,
  });

  factory UpdateSavedMatchesResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateSavedMatchesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateSavedMatchesResponseToJson(this);
}

@JsonSerializable()
class DeviceDetailResponse {
  final DeviceDetail deviceDetail;

  DeviceDetailResponse({
    required this.deviceDetail,
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
