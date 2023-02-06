import "package:flutter/material.dart" show MaterialColor, IconData;
import "package:json_annotation/json_annotation.dart";
import "package:paladinsedge/models/index.dart"
    show MatchPlayerItem, Item, MatchPlayer, Match;

part "match.g.dart";

class MatchTeamStats {
  int kills;
  int deaths;
  int assists;

  MatchTeamStats({
    required this.kills,
    required this.deaths,
    required this.assists,
  });
}

class MatchPlayerHighestStat {
  final String type;
  final int stat;
  final MaterialColor color;
  final IconData icon;

  const MatchPlayerHighestStat({
    required this.type,
    required this.stat,
    required this.color,
    required this.icon,
  });
}

class MatchPlayerItemUsed {
  final MatchPlayerItem playerItem;
  final Item item;

  const MatchPlayerItemUsed({
    required this.playerItem,
    required this.item,
  });
}

@JsonSerializable()
class MatchData {
  final Match match;
  final List<MatchPlayer> matchPlayers;

  MatchData({
    required this.match,
    required this.matchPlayers,
  });

  factory MatchData.fromJson(Map<String, dynamic> json) =>
      _$MatchDataFromJson(json);
  Map<String, dynamic> toJson() => _$MatchDataToJson(this);
}

@JsonSerializable()
class MatchesData {
  final List<Match> matches;
  final List<MatchPlayer> matchPlayers;

  MatchesData({
    required this.matches,
    required this.matchPlayers,
  });

  factory MatchesData.fromJson(Map<String, dynamic> json) =>
      _$MatchesDataFromJson(json);
  Map<String, dynamic> toJson() => _$MatchesDataToJson(this);
}
