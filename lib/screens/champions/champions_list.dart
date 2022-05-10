import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/champions/champion_item.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class ChampionsList extends HookConsumerWidget {
  const ChampionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final combinedChampions = ref.watch(
      providers.champions.select((_) => _.combinedChampions),
    );
    final isLoadingCombinedChampions = ref.watch(
      providers.champions.select((_) => _.isLoadingCombinedChampions),
    );

    // Variables
    int crossAxisCount;
    double horizontalPadding;
    double width;
    final size = MediaQuery.of(context).size;
    final paddingTop = MediaQuery.of(context).padding.top;
    const itemHeight = 120.0;
    final filteredCombinedChampions =
        combinedChampions?.where((_) => !_.hide).toList();

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

    return isLoadingCombinedChampions || filteredCombinedChampions == null
        ? SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                SizedBox(
                  height: size.height / 2 - 50 - paddingTop,
                ),
                isLoadingCombinedChampions
                    ? const widgets.LoadingIndicator(
                        lineWidth: 2,
                        size: 28,
                        label: Text('Getting champions'),
                      )
                    : const Center(
                        child: Text('Unable to load champions data'),
                      ),
              ],
            ),
          )
        : SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 20,
            ),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                mainAxisSpacing: 5,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  final combinedChampion = filteredCombinedChampions[index];

                  return ChampionItem(
                    champion: combinedChampion.champion,
                    playerChampion: combinedChampion.playerChampion,
                    height: itemHeight,
                    width: itemWidth,
                  );
                },
                childCount: filteredCombinedChampions.length,
              ),
            ),
          );
  }
}
