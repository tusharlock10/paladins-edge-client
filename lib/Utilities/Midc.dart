import '../Models/index.dart' as Models;

Models.PlayerChampion? findPlayerChampion(
  List<Models.PlayerChampion> playerChampions,
  String championId,
) {
  final playerChampion = playerChampions.where((playerChampion) {
    return playerChampion.championId == championId;
  }).toList();
  if (playerChampion.length == 0) {
    return null;
  }
  return playerChampion[0];
}
