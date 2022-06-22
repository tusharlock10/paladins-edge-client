import "package:flutter/material.dart" show MaterialColor, IconData;
import "package:paladinsedge/models/index.dart" as models;

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
  final models.MatchPlayerItem playerItem;
  final models.Item item;

  const MatchPlayerItemUsed({
    required this.playerItem,
    required this.item,
  });
}
