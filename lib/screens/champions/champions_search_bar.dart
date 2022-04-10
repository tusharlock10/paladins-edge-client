import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
        championsProvider.clearAppliedFilters();
      },
      [],
    );

    final onFilter = useCallback(
      () {
        showChampionsFilterModal(context);
      },
      [],
    );

    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Theme.of(context).brightness,
      ),
      actions: [
        Row(
          children: [
            IconButton(
              icon: Badge(
                elevation: 0,
                showBadge: selectedFilter.isValid,
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
