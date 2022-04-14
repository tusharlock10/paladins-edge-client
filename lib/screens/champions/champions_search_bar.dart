import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/champions/champions_filter_modal.dart';
import 'package:paladinsedge/theme/index.dart' as theme;

class ChampionsSearchBar extends HookConsumerWidget {
  const ChampionsSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final championsProvider = ref.read(providers.champions);
    final selectedFilter =
        ref.watch(providers.champions.select((_) => _.selectedFilter));

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

    return SliverAppBar(
      snap: true,
      floating: true,
      forceElevated: true,
      actions: [
        Row(
          children: [
            IconButton(
              icon: Badge(
                elevation: 0,
                showBadge: selectedFilter.isValid,
                badgeColor: badgeColor,
                child: const Icon(FontAwesomeIcons.sliders),
              ),
              onPressed: onFilter,
            ),
            IconButton(
              iconSize: 18,
              icon: const Icon(
                FontAwesomeIcons.xmark,
                size: 22,
              ),
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
        decoration: InputDecoration(
          hintText: 'Search champion',
          counterText: "",
          hintStyle: textStyle,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
