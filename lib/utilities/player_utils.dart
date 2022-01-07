import 'package:paladinsedge/models/index.dart' as models;

models.PlayerChampion? findPlayerChampion(
  List<models.PlayerChampion>? playerChampions,
  String championId,
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

  return '$shortTier$tierLevel';
}
