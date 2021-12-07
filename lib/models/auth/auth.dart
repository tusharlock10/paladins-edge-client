// data related to auth module

import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class Essentials {
  final String version;
  final String imageBaseUrl;
  final int forceUpdateFriendsDuration;
  final int forceUpdateMatchesDuration;
  final int forceUpdatePlayerDuration;
  final int forceUpdateChampionsDuration;

  Essentials({
    required this.version,
    required this.imageBaseUrl,
    required this.forceUpdateFriendsDuration,
    required this.forceUpdateMatchesDuration,
    required this.forceUpdatePlayerDuration,
    required this.forceUpdateChampionsDuration,
  });

  factory Essentials.fromJson(Map<String, dynamic> json) =>
      _$EssentialsFromJson(json);
  Map<String, dynamic> toJson() => _$EssentialsToJson(this);
}
