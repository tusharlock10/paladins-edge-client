import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/widgets/index.dart" as widgets;

class PlayerDetailSortTab extends HookConsumerWidget {
  const PlayerDetailSortTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final matchesProvider = ref.read(providers.matches);
    final selectedSort = ref.watch(
      providers.matches.select((_) => _.selectedSort),
    );

    // Variables
    final brightness = Theme.of(context).brightness;
    final textTheme = Theme.of(context).textTheme;

    // Hooks
    final labelColor = useMemoized(
      () {
        return brightness == Brightness.light
            ? theme.themeMaterialColor
            : theme.themeMaterialColor.shade50;
      },
      [brightness],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: data_classes.MatchSort.matchSorts.map(
          (sort) {
            final isSortSelected = selectedSort == sort;

            return widgets.InteractiveCard(
              onTap: () => matchesProvider.setSort(sort),
              elevation: isSortSelected ? 2 : 7,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              borderRadius: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        sort,
                        style: TextStyle(
                          fontSize: 18,
                          color: labelColor,
                        ),
                      ),
                      if (isSortSelected)
                        Text(
                          "Selected",
                          style: TextStyle(
                            fontSize: 12,
                            color: labelColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                    ],
                  ),
                  if (isSortSelected)
                    Text(
                      data_classes.MatchSort.getSortDescription(
                        sort,
                      ),
                      style: textTheme.bodyText1,
                    ),
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
