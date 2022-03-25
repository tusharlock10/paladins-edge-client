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
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));

    // State
    final search = useState('');
    final isLoading = useState(true);

    // Methods
    final getData = useCallback(
      () async {
        await championsProvider.loadChampions();
        isLoading.value = false;
      },
      [],
    );

    // Effects
    useEffect(
      () {
        getData();

        return null;
      },
      [],
    );

    useEffect(
      () {
        championsProvider.loadUserPlayerChampions();

        return null;
      },
      [isGuest],
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
