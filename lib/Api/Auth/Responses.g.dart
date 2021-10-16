// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      player: json['player'] == null
          ? null
          : Player.fromJson(json['player'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
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

ObservePlayerResponse _$ObservePlayerResponseFromJson(
        Map<String, dynamic> json) =>
    ObservePlayerResponse(
      observeList: (json['observeList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ObservePlayerResponseToJson(
        ObservePlayerResponse instance) =>
    <String, dynamic>{
      'observeList': instance.observeList,
    };
