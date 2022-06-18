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

String getKDAFormatted({
  required num kills,
  required num assists,
  required num deaths,
}) {
  if (deaths == 0) return "Perfect";
  final kda = (kills + assists) / deaths;

  return kda.toStringAsPrecision(3);
}

MaterialColor? getKDAColor(String kda) {
  if (kda == "Perfect") return Colors.cyan;
  final numKda = double.tryParse(kda);

  if (numKda == null) return null;
  if (numKda > 3.8) return Colors.green;
  if (numKda > 3) return Colors.orange;
  if (numKda < 1) return Colors.red;

  return null;
}

MaterialColor getWinRateColor(num winRate) {
  if (winRate > 58) return theme.themeMaterialColor;
  if (winRate > 53) return Colors.green;
  if (winRate > 48) return Colors.orange;

  return Colors.red;
}
