import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class ChampionItem extends HookConsumerWidget {
  final models.Champion champion;
  final models.PlayerChampion? playerChampion;
  final double height;
  final double width;
  const ChampionItem({
    required this.champion,
    required this.playerChampion,
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final selectedSort =
        ref.watch(providers.champions.select((_) => _.selectedSort));

    // Variables
    final textTheme = Theme.of(context).textTheme;
    MaterialColor levelColor;
    levelColor = playerChampion?.level != null && playerChampion!.level > 49
        ? Colors.orange
        : Colors.blueGrey;

    // Hooks
    final sortTextChip = useMemoized(
      () {
        return data_classes.ChampionsSort.getSortTextChipValue(
          sort: selectedSort,
          combinedChampion: data_classes.CombinedChampion(
            champion: champion,
            playerChampion: playerChampion,
          ),
        );
      },
      [selectedSort],
    );

    // Methods
    final onTapChampion = useCallback(
      () {
        utilities.unFocusKeyboard(context);
        utilities.Navigation.navigate(
          context,
          screens.ChampionDetail.routeName,
          params: {'championId': champion.championId.toString()},
        );
      },
      [champion],
    );

    return SizedBox(
      width: width,
      height: height,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          onTap: onTapChampion,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Hero(
                    tag: '${champion.championId}Icon',
                    child: LayoutBuilder(
                      builder: (context, constraints) => widgets.ElevatedAvatar(
                        imageUrl: champion.iconUrl,
                        imageBlurHash: champion.iconBlurHash,
                        size: (constraints.maxHeight - 10) / 2,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          champion.name.toUpperCase(),
                          style: textTheme.headline1?.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Wrap(
                        children: [
                          widgets.TextChip(
                            spacing: 5,
                            text: champion.role,
                            color: theme.themeMaterialColor,
                          ),
                          widgets.TextChip(
                            spacing: 5,
                            hidden: playerChampion?.level == null,
                            text: 'Level ${playerChampion?.level.toString()}',
                            color: levelColor,
                          ),
                          widgets.TextChip(
                            spacing: 5,
                            hidden: !champion.onFreeRotation,
                            text: 'Free',
                            icon: Icons.rotate_right,
                            color: Colors.green,
                          ),
                          widgets.TextChip(
                            spacing: 5,
                            hidden: !champion.latestChampion,
                            text: 'New',
                            icon: Icons.star,
                            color: Colors.orange,
                          ),
                          widgets.TextChip(
                            spacing: 5,
                            hidden: sortTextChip == null,
                            text: sortTextChip,
                            color: Colors.pink,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
