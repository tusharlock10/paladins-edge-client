import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;
import "package:substring_highlight/substring_highlight.dart";

class ChampionItem extends HookConsumerWidget {
  final models.Champion champion;
  final models.PlayerChampion? playerChampion;
  final data_classes.ChampionsSearchCondition? searchCondition;
  final double height;
  final double width;
  const ChampionItem({
    required this.champion,
    required this.playerChampion,
    required this.searchCondition,
    required this.height,
    required this.width,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final search = ref.watch(providers.champions.select((_) => _.search));
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));
    final selectedSort = ref.watch(
      providers.champions.select((_) => _.selectedSort),
    );
    final favouriteChampions = ref.watch(
      providers.champions.select((_) => _.favouriteChampions),
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
      [selectedSort, champion, playerChampion],
    );

    final nameSearch = useMemoized(
      () {
        return searchCondition == data_classes.ChampionsSearchCondition.name
            ? search
            : "";
      },
      [search, searchCondition],
    );

    final titleSearch = useMemoized(
      () {
        return searchCondition == data_classes.ChampionsSearchCondition.title
            ? search
            : "";
      },
      [search, searchCondition],
    );

    final championIdSearch = useMemoized(
      () {
        return searchCondition ==
                data_classes.ChampionsSearchCondition.championId
            ? search
            : "";
      },
      [search, searchCondition],
    );

    final levelSearch = useMemoized(
      () {
        return searchCondition == data_classes.ChampionsSearchCondition.level
            ? search
            : "";
      },
      [search, searchCondition],
    );

    final roleSearch = useMemoized(
      () {
        return searchCondition == data_classes.ChampionsSearchCondition.role
            ? search
            : "";
      },
      [search, searchCondition],
    );

    final championIcon = useMemoized(
      () {
        var championIcon = data_classes.PlatformOptimizedImage(
          imageUrl: champion.iconUrl,
          isAssetImage: false,
          blurHash: champion.iconBlurHash,
        );
        if (!constants.isWeb) {
          final assetUrl = utilities.getAssetImageUrl(
            constants.ChampionAssetType.icons,
            champion.championId,
          );
          if (assetUrl != null) {
            championIcon.imageUrl = assetUrl;
            championIcon.isAssetImage = true;
          }
        }

        return championIcon;
      },
      [champion],
    );

    final isFavourite = useMemoized(
      () {
        return favouriteChampions.contains(champion.championId);
      },
      [favouriteChampions, champion],
    );

    // Methods
    final onTapChampion = useCallback(
      () {
        utilities.unFocusKeyboard(context);
        utilities.Navigation.navigate(
          context,
          screens.ChampionDetail.routeName,
          params: {"championId": champion.championId.toString()},
        );
      },
      [champion],
    );

    return SizedBox(
      width: width,
      height: height,
      child: widgets.InteractiveCard(
        borderRadius: 22.5,
        padding: const EdgeInsets.all(5),
        onTap: onTapChampion,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 5),
              child: Hero(
                tag: "${champion.championId}Icon",
                child: LayoutBuilder(
                  builder: (context, constraints) => widgets.ElevatedAvatar(
                    imageUrl: championIcon.imageUrl,
                    imageBlurHash: championIcon.blurHash,
                    isAssetImage: championIcon.isAssetImage,
                    size: (constraints.maxHeight - 10) / 2,
                    margin: const EdgeInsets.all(5),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  SubstringHighlight(
                    text: champion.name.toUpperCase(),
                    term: nameSearch.trim(),
                    textStyle: textTheme.headline1!.copyWith(
                      fontSize: 16,
                    ),
                    textStyleHighlight: textTheme.headline1!.copyWith(
                      fontSize: 16,
                      backgroundColor: highlightColor,
                    ),
                  ),
                  if (championIdSearch.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    SubstringHighlight(
                      text: "Champion ID ${champion.championId}",
                      term: championIdSearch.trim(),
                      textStyle: textTheme.bodyText1!.copyWith(
                        fontSize: 12,
                      ),
                      textStyleHighlight: textTheme.bodyText1!.copyWith(
                        fontSize: 12,
                        backgroundColor: highlightColor,
                      ),
                    ),
                  ],
                  if (titleSearch.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    SubstringHighlight(
                      text: champion.title,
                      term: titleSearch.trim(),
                      textStyle: textTheme.bodyText1!.copyWith(
                        fontSize: 12,
                      ),
                      textStyleHighlight: textTheme.bodyText1!.copyWith(
                        fontSize: 12,
                        backgroundColor: highlightColor,
                      ),
                    ),
                  ],
                  const SizedBox(height: 2),
                  Wrap(
                    children: [
                      widgets.TextChip(
                        spacing: 5,
                        text: champion.role,
                        highlightText: roleSearch.trim(),
                        color: theme.themeMaterialColor,
                      ),
                      if (playerChampion?.level != null)
                        widgets.TextChip(
                          spacing: 5,
                          highlightText: levelSearch,
                          text: "Level ${playerChampion?.level.toString()}",
                          color: levelColor,
                        ),
                      if (champion.onFreeRotation)
                        const widgets.TextChip(
                          spacing: 5,
                          text: "Free",
                          icon: Icons.rotate_right,
                          color: Colors.green,
                        ),
                      if (champion.latestChampion)
                        const widgets.TextChip(
                          spacing: 5,
                          text: "New",
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
            if (!isGuest)
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: widgets.FavouriteStar(
                    isFavourite: isFavourite,
                    hidden: !isFavourite,
                    size: 28,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
