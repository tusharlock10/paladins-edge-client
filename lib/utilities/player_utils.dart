import "package:flutter/material.dart";
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
