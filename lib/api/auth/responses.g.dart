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

CheckPlayerClaimedResponse _$CheckPlayerClaimedResponseFromJson(
        Map<String, dynamic> json) =>
    CheckPlayerClaimedResponse(
      exists: json['exists'] as bool,
    );

Map<String, dynamic> _$CheckPlayerClaimedResponseToJson(
        CheckPlayerClaimedResponse instance) =>
    <String, dynamic>{
      'exists': instance.exists,
    };

ClaimPlayerResponse _$ClaimPlayerResponseFromJson(Map<String, dynamic> json) =>
    ClaimPlayerResponse(
      verified: json['verified'] as bool,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      player: json['player'] == null
          ? null
          : Player.fromJson(json['player'] as Map<String, dynamic>),
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$ClaimPlayerResponseToJson(
        ClaimPlayerResponse instance) =>
    <String, dynamic>{
      'verified': instance.verified,
      'user': instance.user,
      'player': instance.player,
      'reason': instance.reason,
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

FaqsResponse _$FaqsResponseFromJson(Map<String, dynamic> json) => FaqsResponse(
      faqs: (json['faqs'] as List<dynamic>)
          .map((e) => FAQ.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FaqsResponseToJson(FaqsResponse instance) =>
    <String, dynamic>{
      'faqs': instance.faqs,
    };

SavedMatchesResponse _$SavedMatchesResponseFromJson(
        Map<String, dynamic> json) =>
    SavedMatchesResponse(
      matches: (json['matches'] as List<dynamic>)
          .map((e) => Match.fromJson(e as Map<String, dynamic>))
          .toList(),
      matchPlayers: (json['matchPlayers'] as List<dynamic>)
          .map((e) => MatchPlayer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SavedMatchesResponseToJson(
        SavedMatchesResponse instance) =>
    <String, dynamic>{
      'matches': instance.matches,
      'matchPlayers': instance.matchPlayers,
    };

UpdateSavedMatchesResponse _$UpdateSavedMatchesResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateSavedMatchesResponse(
      savedMatches: (json['savedMatches'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UpdateSavedMatchesResponseToJson(
        UpdateSavedMatchesResponse instance) =>
    <String, dynamic>{
      'savedMatches': instance.savedMatches,
    };

DeviceDetailResponse _$DeviceDetailResponseFromJson(
        Map<String, dynamic> json) =>
    DeviceDetailResponse(
      deviceDetail:
          DeviceDetail.fromJson(json['deviceDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeviceDetailResponseToJson(
        DeviceDetailResponse instance) =>
    <String, dynamic>{
      'deviceDetail': instance.deviceDetail,
    };
