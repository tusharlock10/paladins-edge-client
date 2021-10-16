// The match that is currently live
// different from a completed match
import 'package:json_annotation/json_annotation.dart';

part 'active_match.g.dart';

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
  String championImageUrl;
  int team;

  ActiveMatchPlayersInfo({
    required this.player,
    required this.championId,
    required this.championLevel,
    required this.championName,
    required this.championImageUrl,
    required this.team,
  });

  factory ActiveMatchPlayersInfo.fromJson(Map<String, dynamic> json) =>
      _$ActiveMatchPlayersInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ActiveMatchPlayersInfoToJson(this);
}

@JsonSerializable()
class ActiveMatchPlayerDetail {
  String playerId;
  String name;
  String platform;
  int level;
  int rank;
  String? rankName;
  String? rankIconUrl;

  ActiveMatchPlayerDetail({
    required this.playerId,
    required this.name,
    required this.platform,
    required this.level,
    required this.rank,
    required this.rankName,
    required this.rankIconUrl,
  });

  factory ActiveMatchPlayerDetail.fromJson(Map<String, dynamic> json) =>
      _$ActiveMatchPlayerDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ActiveMatchPlayerDetailToJson(this);
}
