import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/champions/champions_list.dart';
import 'package:paladinsedge/screens/champions/champions_search_bar.dart';

class Champions extends HookConsumerWidget {
  static const routeName = '/champions';

  const Champions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final championsProvider = ref.read(providers.champions);
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));

    useEffect(
      () {
        championsProvider.loadCombinedChampions();

        return null;
      },
      [isGuest],
    );

    return const CustomScrollView(
      slivers: [
        ChampionsSearchBar(),
        ChampionsList(),
      ],
    );
  }
}
