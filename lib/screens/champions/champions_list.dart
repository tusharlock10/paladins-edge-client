import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/champions/champion_item.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;

class ChampionsList extends HookConsumerWidget {
  final String search;
  const ChampionsList({
    required this.search,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final champions = ref.read(providers.champions).champions;
    final userPlayerChampions =
        ref.watch(providers.champions.select((_) => _.userPlayerChampions));

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

    // Hooks
    final newChampions = useMemoized(
      () {
        // modify the champions list according to search
        return champions.where((champion) {
          if (search == '') {
            return true;
          } else if (champion.name
              .toUpperCase()
              .contains(search.toUpperCase())) {
            return true;
          }

          return false;
        });
      },
      [search],
    );

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
            userPlayerChampions,
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
