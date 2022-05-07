import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/screens/search/search_app_bar.dart';
import 'package:paladinsedge/screens/search/search_history.dart';
import 'package:paladinsedge/screens/search/search_lower_list.dart';
import 'package:paladinsedge/screens/search/search_top_list.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;

class Search extends HookConsumerWidget {
  static const routeName = '/search';

  const Search({Key? key}) : super(key: key);

  static BeamPage routeBuilder(BuildContext _, BeamState __, Object? ___) =>
      const BeamPage(title: 'Search • Paladins Edge', child: Search());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final searchProvider = ref.watch(providers.players);
    final playersProvider = ref.read(providers.players);
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));

    // State
    final isLoading = useState(false);

    // Methods
    final onSearch = useCallback(
      (
        String playerName, {
        bool addInSearchHistory = true,
      }) async {
        isLoading.value = true;

        final searchProvider = ref.read(providers.players);
        final exactMatch = await searchProvider.searchByName(
          playerName: playerName,
          simpleResults: false,
          addInSearchHistory: addInSearchHistory && !isGuest,
        );

        isLoading.value = false;

        if (exactMatch) {
          utilities.unFocusKeyboard(context);
          context.beamToNamed(screens.PlayerDetail.routeName);
        }
      },
      [],
    );

    // Effects
    useEffect(
      () {
        if (!isGuest) {
          playersProvider.loadSearchHistory();
        }

        return null;
      },
      [isGuest],
    );

    return CustomScrollView(
      slivers: [
        SearchAppBar(isLoading: isLoading.value, onSearch: onSearch),
        searchProvider.topSearchList.isNotEmpty
            ? const SearchTopList()
            : const SearchHistory(),
        if (searchProvider.lowerSearchList.isNotEmpty) const SearchLowerList(),
      ],
    );
  }
}
