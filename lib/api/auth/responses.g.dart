// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
      player: json['player'] == null
          ? null
          : Player.fromJson(json['player'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
      'player': instance.player,
    };

ClaimPlayerResponse _$ClaimPlayerResponseFromJson(Map<String, dynamic> json) =>
    ClaimPlayerResponse(
      verified: json['verified'] as bool,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      player: json['player'] == null
          ? null
          : Player.fromJson(json['player'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClaimPlayerResponseToJson(
        ClaimPlayerResponse instance) =>
    <String, dynamic>{
      'verified': instance.verified,
      'user': instance.user,
      'player': instance.player,
    };

EssentialsResponse _$EssentialsResponseFromJson(Map<String, dynamic> json) =>
    EssentialsResponse(
      essentials:
          Essentials.fromJson(json['essentials'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EssentialsResponseToJson(EssentialsResponse instance) =>
    <String, dynamic>{
      'essentials': instance.essentials,
    };
