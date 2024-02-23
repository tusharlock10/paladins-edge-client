import "package:badges/badges.dart" as badges;
import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/champions/champions_filter_modal.dart";
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class ChampionsSearchBar extends HookConsumerWidget {
  final bool isRefreshing;
  final Future<void> Function() onRefresh;

  const ChampionsSearchBar({
    required this.isRefreshing,
    required this.onRefresh,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final championsProvider = ref.read(providers.champions);
    final appStateProvider = ref.read(providers.appState);
    final selectedFilter = ref.watch(
      providers.champions.select((_) => _.selectedFilter),
    );
    final selectedSort = ref.watch(
      providers.champions.select((_) => _.selectedSort),
    );
    final combinedChampions = ref.watch(
      providers.champions.select((_) => _.combinedChampions),
    );
    final bottomTabIndex = ref.watch(
      providers.appState.select((_) => _.bottomTabIndex),
    );
    final championsTabVisited = ref.watch(
      providers.appState.select((_) => _.championsTabVisited),
    );

    // Variables
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.bodyLarge?.copyWith(fontSize: 16);

    // Hooks
    final focusNode = useFocusNode();
    final textController = useTextEditingController();
    final badgeColor = useMemoized(
      () {
        return isLightTheme
            ? theme.themeMaterialColor.shade50
            : theme.themeMaterialColor;
      },
      [isLightTheme],
    );
    final searchBarColor = useMemoized(
      () => isLightTheme
          ? theme.subtleLightThemeColor
          : theme.subtleDarkThemeColor,
      [isLightTheme],
    );

    useEffect(
      () {
        if (bottomTabIndex == 2 && !championsTabVisited) {
          focusNode.requestFocus();

          if (constants.isMobile) appStateProvider.setChampionsTabVisited(true);
        }

        return null;
      },
      [bottomTabIndex],
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

          utilities.Analytics.logEvent(
            constants.AnalyticsEvent.directSearchChampion,
            {"champion": champion.name},
          );
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
      pinned: !constants.isMobile,
      actions: [
        Row(
          children: [
            widgets.RefreshButton(
              margin: const EdgeInsets.only(right: 10),
              color: Colors.white,
              onRefresh: onRefresh,
              isRefreshing: isRefreshing,
            ),
            IconButton(
              icon: badges.Badge(
                position: badges.BadgePosition.topEnd(top: -4, end: -5),
                showBadge: selectedFilter.isValid ||
                    selectedSort != data_classes.ChampionsSort.defaultSort,
                badgeStyle: badges.BadgeStyle(
                  elevation: 0,
                  badgeColor: badgeColor,
                ),
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
        focusNode: focusNode,
        controller: textController,
        maxLength: 16,
        enableInteractiveSelection: true,
        style: textStyle?.copyWith(color: Colors.white),
        onChanged: championsProvider.filterChampionsBySearch,
        onSubmitted: onSubmit,
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          hintText: "Search champion",
          counterText: "",
          hintStyle: textStyle?.copyWith(color: Colors.white70),
          fillColor: searchBarColor,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
      ),
    );
  }
}
