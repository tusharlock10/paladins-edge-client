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
import 'package:substring_highlight/substring_highlight.dart';

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
    final search = ref.watch(providers.champions.select((_) => _.search));
    final selectedSort = ref.watch(
      providers.champions.select((_) => _.selectedSort),
    );

    // Variables
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final highlightColor = isLightTheme
        ? theme.themeMaterialColor.shade50
        : theme.darkThemeMaterialColor.shade50;
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
      [],
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
                      SubstringHighlight(
                        text: champion.name.toUpperCase(),
                        term: search,
                        textStyle: textTheme.headline1!.copyWith(
                          fontSize: 16,
                        ),
                        textStyleHighlight: textTheme.headline1!.copyWith(
                          fontSize: 16,
                          backgroundColor: highlightColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      if (search != '' &&
                          champion.title
                              .toLowerCase()
                              .contains(search.toLowerCase()))
                        SubstringHighlight(
                          text: champion.title,
                          term: search,
                          textStyle: textTheme.bodyText1!.copyWith(
                            fontSize: 12,
                          ),
                          textStyleHighlight: textTheme.bodyText1!.copyWith(
                            fontSize: 12,
                            backgroundColor: highlightColor,
                          ),
                        ),
                      const SizedBox(height: 5),
                      Wrap(
                        children: [
                          widgets.TextChip(
                            spacing: 5,
                            text: champion.role,
                            color: theme.themeMaterialColor,
                          ),
                          if (playerChampion?.level != null)
                            widgets.TextChip(
                              spacing: 5,
                              text: 'Level ${playerChampion?.level.toString()}',
                              color: levelColor,
                            ),
                          if (champion.onFreeRotation)
                            const widgets.TextChip(
                              spacing: 5,
                              text: 'Free',
                              icon: Icons.rotate_right,
                              color: Colors.green,
                            ),
                          if (champion.latestChampion)
                            const widgets.TextChip(
                              spacing: 5,
                              text: 'New',
                              icon: Icons.star,
                              color: Colors.orange,
                            ),
                          if (sortTextChip != null)
                            widgets.TextChip(
                              spacing: 5,
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
