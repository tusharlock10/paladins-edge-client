// data related to essentials

import "package:hive/hive.dart";
import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/constants.dart" show TypeIds;

part "essentials.g.dart";

// model for storing app essentials locally
@HiveType(typeId: TypeIds.essentials)
@JsonSerializable()
class Essentials extends HiveObject {
  /// version of the api
  @HiveField(0)
  final String version;

  /// base image url for getting images
  @HiveField(1)
  final String imageBaseUrl;

  /// max number of favourite friends each user can have
  @HiveField(2)
  final int maxFavouriteFriends;

  /// interval duration for player friends forced update
  @HiveField(3)
  final int forceUpdateFriendsDuration;

  /// interval duration for player matches forced update
  @HiveField(4)
  final int forceUpdateMatchesDuration;

  /// interval duration for player profile forced update
  @HiveField(5)
  final int forceUpdatePlayerDuration;

  /// interval duration for player champions forced update
  @HiveField(6)
  final int forceUpdateChampionsDuration;

  /// interval duration for player loadouts forced update
  @HiveField(7)
  final int forceUpdatePlayerLoadouts;

  Essentials({
    required this.version,
    required this.imageBaseUrl,
    required this.forceUpdateFriendsDuration,
    required this.forceUpdateMatchesDuration,
    required this.forceUpdatePlayerDuration,
    required this.forceUpdateChampionsDuration,
    required this.maxFavouriteFriends,
    required this.forceUpdatePlayerLoadouts,
  });

  factory Essentials.fromJson(Map<String, dynamic> json) =>
      _$EssentialsFromJson(json);
  Map<String, dynamic> toJson() => _$EssentialsToJson(this);
}
