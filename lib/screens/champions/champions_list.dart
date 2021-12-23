import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/champions/champion_item.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;

class ChampionsList extends ConsumerWidget {
  final String search;
  const ChampionsList({
    required this.search,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final championsProvider = ref.read(providers.champions);
    final champions = championsProvider.champions;
    final playerChampions = championsProvider.playerChampions;
    final size = MediaQuery.of(context).size;
    const itemHeight = 120.0;
    int crossAxisCount;
    double horizontalPadding;
    double width;

    if (size.height < size.width) {
      // for landscape mode
      crossAxisCount = 2;
      width = size.width * 0.75;
      horizontalPadding = (size.width - width) / 2;
    } else {
      // for portrait mode
      crossAxisCount = 1;
      width = size.width;
      horizontalPadding = 15;
    }

    final itemWidth = width / crossAxisCount;
    double childAspectRatio = itemWidth / itemHeight;

    // modify the champions list according to search
    final newChampions = champions.where((champion) {
      if (search == '') {
        return true;
      } else if (champion.name.toUpperCase().contains(search.toUpperCase())) {
        return true;
      }

      return false;
    });

    return GridView.count(
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      mainAxisSpacing: 5,
      physics: const BouncingScrollPhysics(),
      padding:
          EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
      children: newChampions.map(
        (champion) {
          final playerChampion = utilities.findPlayerChampion(
            playerChampions,
            champion.championId,
          );

          return ChampionItem(
            champion: champion,
            playerChampion: playerChampion,
            height: itemHeight,
            width: itemWidth,
          );
        },
      ).toList(),
    );
  }
}
