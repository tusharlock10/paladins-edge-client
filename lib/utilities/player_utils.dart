import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/theme/index.dart" as theme;

models.PlayerChampion? findPlayerChampion(
  List<models.PlayerChampion>? playerChampions,
  int championId,
) {
  if (playerChampions == null) return null;

  final playerChampion = playerChampions.where((playerChampion) {
    return playerChampion.championId == championId;
  }).toList();
  if (playerChampion.isEmpty) {
    return null;
  }

  return playerChampion.first;
}

String shortRankName(String rankName) {
  if (rankName.toLowerCase().contains("gran")) return "GM"; // Grandmaster
  if (rankName.toLowerCase().contains("mast")) return "MS"; // Master
  if (rankName.toLowerCase().contains("qual")) return "QL"; // Qualifying

  final temp = rankName.split(" ");
  final shortTier = temp.first[0];
  String tierLevel = "";

  if (temp[1] == "I") tierLevel = "1";
  if (temp[1] == "II") tierLevel = "2";
  if (temp[1] == "III") tierLevel = "3";
  if (temp[1] == "IV") tierLevel = "4";
  if (temp[1] == "V") tierLevel = "5";

  return "$shortTier$tierLevel";
}

MaterialColor? getKDAColor(double kda) {
  if (kda == -1) return Colors.cyan;

  if (kda > 3.8) return Colors.green;
  if (kda > 3) return Colors.orange;
  if (kda < 1) return Colors.red;

  return null;
}

MaterialColor getWinRateColor(num winRate) {
  if (winRate < 1) winRate = winRate * 100;

  if (winRate > 58) return theme.themeMaterialColor;
  if (winRate > 53) return Colors.green;
  if (winRate > 48) return Colors.orange;

  return Colors.red;
}

data_classes.MatchPlayerHighestStat matchPlayerHighestStat(
  models.MatchPlayerStats playerStats,
  String? role, [
  bool compact = false,
]) {
  final totalDamageDealt = playerStats.totalDamageDealt;
  final totalDamageTaken = playerStats.totalDamageTaken;
  final healingDone = playerStats.healingDone;
  final damageShielded = playerStats.damageShielded;
  num maxStat;
  String type;
  MaterialColor color;
  IconData icon;

  if (role == constants.ChampionRoles.damage) {
    maxStat = totalDamageDealt;
  } else if (role == constants.ChampionRoles.flank) {
    maxStat = [totalDamageDealt, healingDone].max()!.toInt();
  } else {
    maxStat = [
      totalDamageDealt,
      totalDamageTaken,
      healingDone,
      damageShielded,
    ].max()!;
  }

  if (maxStat == damageShielded) {
    type = compact ? "Shield" : "Shielded";
    color = theme.themeMaterialColor;
    icon = FeatherIcons.shield;
  } else if (maxStat == totalDamageTaken) {
    type = compact ? "Tank" : "Tanked";
    icon = FeatherIcons.heart;
    color = Colors.purple;
  } else if (maxStat == healingDone) {
    type = compact ? "Heal" : "Healed";
    color = Colors.green;
    icon = FeatherIcons.activity;
  } else {
    type = compact ? "Dmg" : "Damage";
    color = Colors.red;
    icon = FeatherIcons.crosshair;
  }

  return data_classes.MatchPlayerHighestStat(
    color: color,
    type: type,
    stat: maxStat.toInt(),
    icon: icon,
  );
}
