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
    final search = useState('');
    final isLoading = useState(true);

    useEffect(
      () {
        final championsProvider = ref.read(providers.champions);
        final authProvider = ref.read(providers.auth);

        Future.wait([
          championsProvider.loadChampions(),
          championsProvider.getPlayerChampions(authProvider.player!.playerId),
        ]).then((_) {
          isLoading.value = false;
        });
      },
      [],
    );

    return Column(
      children: [
        ChampionsSearchBar(
          onChanged: (_search) => search.value = _search,
          onPressed: () => search.value = '',
        ),
        Expanded(
          child: isLoading.value
              ? const Center(
                  child: widgets.LoadingIndicator(
                    size: 36,
                    color: theme.themeMaterialColor,
                  ),
                )
              : ChampionsList(search: search.value),
        ),
      ],
    );
  }
}
