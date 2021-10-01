// The match that is currently live
// different from a completed match
import 'package:json_annotation/json_annotation.dart';

part 'ActiveMatch.g.dart';

@JsonSerializable()
class ActiveMatch {
  int matchId;
  String queue;
  String map;
  String region;
  List<ActiveMatchPlayersInfo> playersInfo;

  ActiveMatch({
    required this.matchId,
    required this.queue,
    required this.map,
    required this.region,
    required this.playersInfo,
  });
  factory ActiveMatch.fromJson(Map<String, dynamic> json) =>
      _$ActiveMatchFromJson(json);
  Map<String, dynamic> toJson() => _$ActiveMatchToJson(this);
}

@JsonSerializable()
class ActiveMatchPlayersInfo {
  ActiveMatchPlayerDetail player;
  int championId;
  int championLevel;
  String championName;

  ActiveMatchPlayersInfo({
    required this.player,
    required this.championId,
    required this.championLevel,
    required this.championName,
  });

  factory ActiveMatchPlayersInfo.fromJson(Map<String, dynamic> json) =>
      _$ActiveMatchPlayersInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ActiveMatchPlayersInfoToJson(this);
}

@JsonSerializable()
class ActiveMatchPlayerDetail {
  int playerId;
  String name;
  String platform;
  int level;

  ActiveMatchPlayerDetail({
    required this.playerId,
    required this.name,
    required this.platform,
    required this.level,
  });

  factory ActiveMatchPlayerDetail.fromJson(Map<String, dynamic> json) =>
      _$ActiveMatchPlayerDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ActiveMatchPlayerDetailToJson(this);
}
