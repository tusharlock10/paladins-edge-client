import "package:flutter/material.dart";
import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/models/player/player.dart";
import "package:paladinsedge/models/user/user.dart";

part "auth.g.dart";

enum FavouriteFriendResult {
  removed,
  added,
  limitReached,
  unauthorized,
  reverted
}

enum SaveMatchResult { removed, added, limitReached, unauthorized, reverted }

class ShowLoginModalOptions {
  final BuildContext context;
  final String loginCta;

  ShowLoginModalOptions({
    required this.context,
    required this.loginCta,
  });
}

class SignInProviderResponse {
  final bool result;
  final int? errorCode;
  final String? errorMessage;

  SignInProviderResponse({
    required this.result,
    this.errorCode,
    this.errorMessage,
  });
}

@JsonSerializable()
class LoginData {
  final User user;
  final String token;
  final Player? player;

  LoginData({
    required this.user,
    required this.token,
    this.player,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}

@JsonSerializable()
class ClaimPlayerData {
  final bool verified;
  final User? user;
  final Player? player;
  final String? reason;

  ClaimPlayerData({
    required this.verified,
    this.user,
    this.player,
    this.reason,
  });

  factory ClaimPlayerData.fromJson(Map<String, dynamic> json) =>
      _$ClaimPlayerDataFromJson(json);
  Map<String, dynamic> toJson() => _$ClaimPlayerDataToJson(this);
}
