// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Essentials _$EssentialsFromJson(Map<String, dynamic> json) => Essentials(
      version: json['version'] as String,
      imageBaseUrl: json['imageBaseUrl'] as String,
      forceUpdateFriendsDuration: json['forceUpdateFriendsDuration'] as int,
      forceUpdateMatchesDuration: json['forceUpdateMatchesDuration'] as int,
      forceUpdatePlayerDuration: json['forceUpdatePlayerDuration'] as int,
      forceUpdateChampionsDuration: json['forceUpdateChampionsDuration'] as int,
    );

Map<String, dynamic> _$EssentialsToJson(Essentials instance) =>
    <String, dynamic>{
      'version': instance.version,
      'imageBaseUrl': instance.imageBaseUrl,
      'forceUpdateFriendsDuration': instance.forceUpdateFriendsDuration,
      'forceUpdateMatchesDuration': instance.forceUpdateMatchesDuration,
      'forceUpdatePlayerDuration': instance.forceUpdatePlayerDuration,
      'forceUpdateChampionsDuration': instance.forceUpdateChampionsDuration,
    };
