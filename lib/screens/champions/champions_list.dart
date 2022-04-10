import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/champions/champion_item.dart';

class ChampionsList extends HookConsumerWidget {
  const ChampionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final combinedChampions =
        ref.watch(providers.champions.select((_) => _.combinedChampions));

    // Variables
    int crossAxisCount;
    double horizontalPadding;
    double width;
    final size = MediaQuery.of(context).size;
    const itemHeight = 120.0;

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

    return combinedChampions == null
        ? const SizedBox()
        : GridView.count(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            mainAxisSpacing: 5,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 20,
            ),
            children: combinedChampions
                .where((combinedChampion) => !combinedChampion.hide)
                .map(
              (combinedChampion) {
                return ChampionItem(
                  champion: combinedChampion.champion,
                  playerChampion: combinedChampion.playerChampion,
                  height: itemHeight,
                  width: itemWidth,
                );
              },
            ).toList(),
          );
  }
}
