import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:jiffy/jiffy.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:timer_builder/timer_builder.dart";

class SearchHistory extends HookConsumerWidget {
  final String searchValue;
  const SearchHistory({
    required this.searchValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final searchHistory = ref.watch(
      providers.players.select((_) => _.searchHistory),
    );

    // Variables
    final textTheme = Theme.of(context).textTheme;

    // Hooks
    final filteredSearchHistory = useMemoized(
      () {
        return searchHistory.where(
          (_) => _.playerName.toLowerCase().contains(searchValue),
        );
      },
      [searchValue, searchHistory],
    );

    // Methods
    final onTap = useCallback(
      (String playerId) {
        utilities.Analytics.logEvent(
          constants.AnalyticsEvent.clickSearchHistory,
        );
        utilities.unFocusKeyboard(context);
        utilities.Navigation.navigate(
          context,
          screens.PlayerDetail.routeName,
          params: {
            "playerId": playerId,
          },
        );
      },
      [],
    );

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final search = filteredSearchHistory.elementAt(index);

          return ListTile(
            onTap: () => onTap(search.playerId),
            title: Text(
              search.playerName,
              style: textTheme.titleLarge?.copyWith(fontSize: 16),
            ),
            trailing: TimerBuilder.periodic(
              const Duration(minutes: 1),
              builder: (context) {
                return Text(
                  Jiffy.parseFromDateTime(search.time).fromNow(),
                  style: textTheme.bodyLarge?.copyWith(fontSize: 12),
                );
              },
            ),
          );
        },
        childCount: filteredSearchHistory.length,
      ),
    );
  }
}
