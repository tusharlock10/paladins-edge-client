import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/player_detail/player_detail_datepicker_modal.dart";
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/widgets/index.dart" as widgets;

class PlayerDetailFilterTab extends HookConsumerWidget {
  const PlayerDetailFilterTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final matchesProvider = ref.read(providers.matches);
    final selectedFilter = ref.watch(
      providers.matches.select((_) => _.selectedFilter),
    );

    // Variables
    final brightness = Theme.of(context).brightness;
    final textTheme = Theme.of(context).textTheme;

    // State
    final openedFilterName = useState(selectedFilter.name);

    // Hooks
    final labelColor = useMemoized(
      () {
        return brightness == Brightness.light
            ? theme.themeMaterialColor
            : theme.themeMaterialColor.shade50;
      },
      [brightness],
    );

    // Methods
    final onTapFilter = useCallback(
      (
        bool isFilterValueSelected,
        String filterName,
        data_classes.MatchFilterValue filterValue,
      ) {
        if (isFilterValueSelected) {
          return matchesProvider.setFilterValue(null, null);
        }

        if (filterValue.type == data_classes.MatchFilterValueType.dates) {
          return showPlayerDetailDatePickerModal(
            context,
            filterName,
            filterValue,
            matchesProvider.setFilterValue,
          );
        }

        matchesProvider.setFilterValue(filterName, filterValue);
      },
      [],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: data_classes.MatchFilter.filterNames.map(
          (filterName) {
            final isFilterOpened = openedFilterName.value == filterName;
            final isFilterNameSelected = selectedFilter.name == filterName;

            return widgets.InteractiveCard(
              onTap: () =>
                  isFilterOpened ? null : openedFilterName.value = filterName,
              elevation: isFilterOpened ? 2 : 7,
              margin: const EdgeInsets.all(10),
              borderRadius: 10,
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
                            "Selected",
                            style: TextStyle(
                              fontSize: 12,
                              color: labelColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                    if (isFilterOpened)
                      Text(
                        data_classes.MatchFilter.getFilterDescription(
                          filterName,
                        ),
                        style: textTheme.bodyText1,
                      ),
                    if (isFilterOpened) const SizedBox(height: 10),
                    if (isFilterOpened)
                      Wrap(
                        children: data_classes.MatchFilter.getFilterValues(
                          filterName,
                        )!
                            .map(
                          (filterValue) {
                            final isFilterValueSelected =
                                filterValue.isSameFilter(selectedFilter.value);

                            return widgets.TextChip(
                              spacing: 5,
                              textSize: 12,
                              iconSize: 14,
                              text: isFilterValueSelected
                                  ? selectedFilter.value!.valueName
                                  : filterValue.valueName,
                              icon: isFilterValueSelected ? Icons.check : null,
                              color: isFilterValueSelected
                                  ? theme.themeMaterialColor
                                  : Colors.blueGrey,
                              onTap: () => onTapFilter(
                                isFilterValueSelected,
                                filterName,
                                filterValue,
                              ),
                            );
                          },
                        ).toList(),
                      ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
