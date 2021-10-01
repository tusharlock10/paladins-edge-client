import 'package:json_annotation/json_annotation.dart';

import '../../Models/index.dart' show User, Player;

part 'Responses.g.dart';

@JsonSerializable()
class LoginResponse {
  final User user;
  final Player? player;

  LoginResponse({
    required this.user,
    this.player,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class ClaimPlayerResponse {
  final bool verified;
  final User user;
  final Player? player;

  ClaimPlayerResponse({
    required this.verified,
    required this.user,
    this.player,
  });

  factory ClaimPlayerResponse.fromJson(Map<String, dynamic> json) =>
      _$ClaimPlayerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ClaimPlayerResponseToJson(this);
}

@JsonSerializable()
class ObservePlayerResponse {
  final User user;
  ObservePlayerResponse({required this.user});

  factory ObservePlayerResponse.fromJson(Map<String, dynamic> json) =>
      _$ObservePlayerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ObservePlayerResponseToJson(this);
}
