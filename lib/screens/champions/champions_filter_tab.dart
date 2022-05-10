import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:touchable_opacity/touchable_opacity.dart';

class ChampionsFilterTab extends HookConsumerWidget {
  const ChampionsFilterTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final championsProvider = ref.read(providers.champions);
    final selectedFilter =
        ref.watch(providers.champions.select((_) => _.selectedFilter));

    // Variables
    final brightness = Theme.of(context).brightness;
    final textTheme = Theme.of(context).textTheme;

    // State
    final hoverFilterName = useState<String?>(null);

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
        children: data_classes.ChampionsFilter.filterNames.map(
          (filterName) {
            final isFilterNameSelected = selectedFilter.name == filterName;

            return TouchableOpacity(
              onTap: isFilterNameSelected
                  ? null
                  : () => championsProvider.setFilterName(filterName),
              activeOpacity: isFilterNameSelected ? 1 : 0.5,
              child: MouseRegion(
                onEnter: (_) => hoverFilterName.value = filterName,
                onExit: (_) => hoverFilterName.value = null,
                child: Card(
                  elevation: isFilterNameSelected ? 3 : 7,
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    side: hoverFilterName.value == filterName
                        ? BorderSide(
                            color: labelColor,
                            width: 2,
                          )
                        : BorderSide.none,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              filterName,
                              style: TextStyle(
                                fontSize: 18,
                                color: labelColor,
                              ),
                            ),
                            if (isFilterNameSelected)
                              Text(
                                'Selected',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: labelColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                          ],
                        ),
                        if (isFilterNameSelected)
                          Text(
                            data_classes.ChampionsFilter.getFilterDescription(
                              filterName,
                            ),
                            style: textTheme.bodyText1,
                          ),
                        if (isFilterNameSelected) const SizedBox(height: 10),
                        if (isFilterNameSelected)
                          Wrap(
                            children:
                                data_classes.ChampionsFilter.getFilterValues(
                              filterName,
                            )!
                                    .map(
                              (filterValue) {
                                final isFilterValueSelected =
                                    selectedFilter.value == filterValue;

                                return widgets.TextChip(
                                  spacing: 5,
                                  textSize: 12,
                                  iconSize: 14,
                                  text: filterValue,
                                  icon: isFilterValueSelected
                                      ? Icons.check
                                      : null,
                                  color: isFilterValueSelected
                                      ? theme.themeMaterialColor
                                      : Colors.blueGrey,
                                  onTap: () => championsProvider.setFilterValue(
                                    isFilterValueSelected ? null : filterValue,
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
