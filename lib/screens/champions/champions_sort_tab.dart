import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:touchable_opacity/touchable_opacity.dart';

class ChampionsSortTab extends HookConsumerWidget {
  const ChampionsSortTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final championsProvider = ref.read(providers.champions);
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));
    final selectedSort =
        ref.watch(providers.champions.select((_) => _.selectedSort));

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
          children: data_classes.ChampionsSort.championSorts(isGuest).map(
            (sort) {
              final isSortSelected = selectedSort == sort;

              return TouchableOpacity(
                onTap: isSortSelected
                    ? null
                    : () => championsProvider.setSort(sort),
                activeOpacity: isSortSelected ? 1 : 0.5,
                child: Card(
                  elevation: isSortSelected ? 7 : 0,
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
                              sort,
                              style: TextStyle(
                                fontSize: 18,
                                color: labelColor,
                              ),
                            ),
                            if (isSortSelected)
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
                        if (isSortSelected)
                          Text(
                            data_classes.ChampionsSort.getSortDescription(
                              sort,
                            ),
                            style: textTheme.bodyText1,
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
