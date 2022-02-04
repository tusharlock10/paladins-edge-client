import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/screens/search/search_history.dart';
import 'package:paladinsedge/screens/search/search_list.dart';
import 'package:paladinsedge/screens/search/top_search_bar.dart';

class Search extends HookConsumerWidget {
  static const routeName = '/search';

  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final searchProvider = ref.watch(providers.players);
    final playersProvider = ref.read(providers.players);

    // State
    final isLoading = useState(false);
    final playerName = useState('');

    // Methods
    final onSearch = useCallback(
      (
        String playerName, {
        bool addInSeachHistory = true,
      }) async {
        isLoading.value = true;

        final searchProvider = ref.read(providers.players);
        final exactMatch = await searchProvider.searchByName(
          playerName: playerName,
          simpleResults: false,
          addInSeachHistory: addInSeachHistory,
        );

        isLoading.value = false;

        if (exactMatch) {
          Navigator.pushNamed(context, screens.PlayerDetail.routeName);
        }
      },
      [],
    );

    final onTapSearchHistory = useCallback(
      (String _playerName) {
        playerName.value = _playerName;
        onSearch(playerName.value, addInSeachHistory: false);
      },
      [],
    );

    // Effects
    useEffect(
      () {
        playersProvider.getSearchHistory();

        return null;
      },
      [],
    );

    return CustomScrollView(
      slivers: [
        TopSearchBar(isLoading: isLoading.value, onSearch: onSearch),
        searchProvider.topSearchList.isNotEmpty
            ? const SearchList()
            : SearchHistory(
                playerName: playerName.value,
                onTap: onTapSearchHistory,
              ),
      ],
    );
  }
}
