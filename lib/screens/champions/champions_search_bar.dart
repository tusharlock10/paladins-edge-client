import "package:badges/badges.dart";
import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/champions/champions_filter_modal.dart";
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;

class ChampionsSearchBar extends HookConsumerWidget {
  const ChampionsSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final championsProvider = ref.read(providers.champions);
    final selectedFilter = ref.watch(
      providers.champions.select((_) => _.selectedFilter),
    );
    final selectedSort = ref.watch(
      providers.champions.select((_) => _.selectedSort),
    );
    final combinedChampions = ref.watch(
      providers.champions.select((_) => _.combinedChampions),
    );

    // Variables
    final brightness = Theme.of(context).brightness;
    final textController = useTextEditingController();
    final textStyle = Theme.of(context).textTheme.headline6?.copyWith(
          color: Colors.white,
          fontSize: 16,
        );

    // Hooks
    final badgeColor = useMemoized(
      () {
        return brightness == Brightness.light
            ? theme.themeMaterialColor.shade50
            : theme.themeMaterialColor;
      },
      [brightness],
    );

    // Methods
    final onClear = useCallback(
      () {
        textController.clear();
        championsProvider.clearAppliedFiltersAndSort();
      },
      [],
    );

    final onFilter = useCallback(
      () {
        showChampionsFilterModal(context);
      },
      [],
    );

    final onSubmit = useCallback(
      (String? _) {
        if (combinedChampions == null) return;
        final filteredCombinedChampions =
            combinedChampions.where((_) => !_.hide);
        if (filteredCombinedChampions.length == 1) {
          final champion = filteredCombinedChampions.first.champion;
          utilities.unFocusKeyboard(context);
          utilities.Navigation.navigate(
            context,
            screens.ChampionDetail.routeName,
            params: {"championId": champion.championId.toString()},
          );
        }
      },
      [combinedChampions],
    );

    return SliverAppBar(
      snap: true,
      floating: true,
      forceElevated: true,
      pinned: constants.isWeb,
      actions: [
        Row(
          children: [
            IconButton(
              icon: Badge(
                elevation: 0,
                position: BadgePosition.topEnd(top: -4, end: -5),
                showBadge: selectedFilter.isValid ||
                    selectedSort != data_classes.ChampionsSort.defaultSort,
                badgeColor: badgeColor,
                child: const Icon(FeatherIcons.sliders),
              ),
              onPressed: onFilter,
            ),
            IconButton(
              iconSize: 18,
              icon: const Icon(Icons.clear),
              onPressed: onClear,
            ),
            const SizedBox(width: 10),
          ],
        ),
      ],
      title: TextField(
        controller: textController,
        maxLength: 16,
        enableInteractiveSelection: true,
        style: textStyle,
        onChanged: championsProvider.filterChampionsBySearch,
        onSubmitted: onSubmit,
        decoration: InputDecoration(
          hintText: "Search champion",
          counterText: "",
          hintStyle: textStyle,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
