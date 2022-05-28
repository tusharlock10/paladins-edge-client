import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/champions/champions_list.dart";
import "package:paladinsedge/screens/champions/champions_search_bar.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class Champions extends HookConsumerWidget {
  const Champions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final championsProvider = ref.read(providers.champions);
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));

    // Effects
    useEffect(
      () {
        championsProvider.loadCombinedChampions(false);

        return null;
      },
      [isGuest],
    );

    return widgets.Refresh(
      edgeOffset: utilities.getTopEdgeOffset(context),
      onRefresh: () => championsProvider.loadCombinedChampions(true),
      child: const CustomScrollView(
        slivers: [
          ChampionsSearchBar(),
          ChampionsList(),
        ],
      ),
    );
  }
}
