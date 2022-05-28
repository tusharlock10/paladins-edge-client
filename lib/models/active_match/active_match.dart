// The match that is currently live
// different from a completed match
import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/models/player/player.dart" show Ranked;
import "package:paladinsedge/utilities/index.dart" as utilities;

part "active_match.g.dart";

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
  Ranked? ranked;
  int championId;
  int championLevel;
  String championName;
  String championImageUrl;
  int team;

  ActiveMatchPlayersInfo({
    required this.player,
    this.ranked,
    required this.championId,
    required this.championLevel,
    required this.championName,
    required String championImageUrl,
    required this.team,
  }) : championImageUrl = utilities.getUrlFromKey(championImageUrl);

  factory ActiveMatchPlayersInfo.fromJson(Map<String, dynamic> json) =>
      _$ActiveMatchPlayersInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ActiveMatchPlayersInfoToJson(this);
}

@JsonSerializable()
class ActiveMatchPlayerDetail {
  String playerId;
  String playerName;
  String platform;
  int level;

  ActiveMatchPlayerDetail({
    required this.playerId,
    required this.playerName,
    required this.platform,
    required this.level,
  });

  factory ActiveMatchPlayerDetail.fromJson(Map<String, dynamic> json) =>
      _$ActiveMatchPlayerDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ActiveMatchPlayerDetailToJson(this);
}
