import "package:flutter/material.dart" show MaterialColor, IconData;

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
