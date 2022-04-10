import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/champions/champions_list.dart';
import 'package:paladinsedge/screens/champions/champions_search_bar.dart';
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class Champions extends HookConsumerWidget {
  static const routeName = '/champions';

  const Champions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final championsProvider = ref.read(providers.champions);
    final isLoadingCombinedChampions = ref
        .watch(providers.champions.select((_) => _.isLoadingCombinedChampions));
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));

    useEffect(
      () {
        championsProvider.loadCombinedChampions();

        return null;
      },
      [isGuest],
    );

    return Column(
      children: [
        const ChampionsSearchBar(),
        Expanded(
          child: isLoadingCombinedChampions
              ? const Center(
                  child: widgets.LoadingIndicator(
                    size: 36,
                    color: theme.themeMaterialColor,
                  ),
                )
              : const ChampionsList(),
        ),
      ],
    );
  }
}
