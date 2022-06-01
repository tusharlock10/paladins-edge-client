import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:jiffy/jiffy.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:timer_builder/timer_builder.dart";

class SearchHistory extends HookConsumerWidget {
  const SearchHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final searchHistory = ref.watch(
      providers.players.select((_) => _.searchHistory),
    );

    // Variables
    final textTheme = Theme.of(context).textTheme;

    // Methods
    final onTap = useCallback(
      (String playerId) {
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
          final search = searchHistory[index];

          return ListTile(
            onTap: () => onTap(search.playerId),
            title: Text(
              search.playerName,
              style: textTheme.headline6?.copyWith(fontSize: 16),
            ),
            trailing: TimerBuilder.periodic(
              const Duration(minutes: 1),
              builder: (context) {
                return Text(
                  Jiffy(search.time).fromNow(),
                  style: textTheme.bodyText1?.copyWith(fontSize: 12),
                );
              },
            ),
          );
        },
        childCount: searchHistory.length,
      ),
    );
  }
}
