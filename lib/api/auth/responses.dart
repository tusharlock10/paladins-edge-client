import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/models/index.dart"
    show
        User,
        Player,
        Essentials,
        FAQ,
        Match,
        MatchPlayer,
        DeviceDetail,
        BaseRank,
        Sponsor;

part "responses.g.dart";

@JsonSerializable()
class LoginResponse {
  final User user;
  final String token;
  final Player? player;

  LoginResponse({
    required this.user,
    required this.token,
    this.player,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class ConnectPlayerResponse {
  final User user;
  final Player player;

  ConnectPlayerResponse({
    required this.user,
    required this.player,
  });

  factory ConnectPlayerResponse.fromJson(Map<String, dynamic> json) =>
      _$ConnectPlayerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ConnectPlayerResponseToJson(this);
}

@JsonSerializable()
class EssentialsResponse {
  final Essentials essentials;

  EssentialsResponse({
    required this.essentials,
  });

  factory EssentialsResponse.fromJson(Map<String, dynamic> json) =>
      _$EssentialsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EssentialsResponseToJson(this);
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

@JsonSerializable()
class BaseRankResponse {
  final List<BaseRank> ranks;

  BaseRankResponse({
    required this.ranks,
  });

  factory BaseRankResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseRankResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BaseRankResponseToJson(this);
}

@JsonSerializable()
class SponsorResponse {
  final List<Sponsor> sponsors;

  SponsorResponse({
    required this.sponsors,
  });

  factory SponsorResponse.fromJson(Map<String, dynamic> json) =>
      _$SponsorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SponsorResponseToJson(this);
}
