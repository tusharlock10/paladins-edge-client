import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

    // Hooks
    final labelColor = useMemoized(
      () {
        return brightness == Brightness.light
            ? theme.themeMaterialColor
            : theme.themeMaterialColor.shade50;
      },
      [brightness],
    );

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(3),
          topRight: Radius.circular(3),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Padding(
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
                child: Card(
                  elevation: isFilterNameSelected ? 7 : 0,
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(
                      color: labelColor,
                      width: 2,
                    ),
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
                                  iconSize: 12,
                                  text: filterValue,
                                  icon: isFilterValueSelected
                                      ? FontAwesomeIcons.solidCircleDot
                                      : FontAwesomeIcons.circle,
                                  color: isFilterValueSelected
                                      ? theme.themeMaterialColor
                                      : Colors.blueGrey,
                                  onTap: () => championsProvider
                                      .setFilterValue(filterValue),
                                );
                              },
                            ).toList(),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
