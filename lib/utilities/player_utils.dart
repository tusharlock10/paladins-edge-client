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
