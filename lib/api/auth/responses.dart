import 'package:json_annotation/json_annotation.dart';
import 'package:paladinsedge/models/index.dart' show User, Player, Essentials;

part 'responses.g.dart';

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
class EssentialsResponse {
  final Essentials essentials;

  EssentialsResponse({
    required this.essentials,
  });

  factory EssentialsResponse.fromJson(Map<String, dynamic> json) =>
      _$EssentialsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EssentialsResponseToJson(this);
}
