import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/screens/search/search_bar.dart';
import 'package:paladinsedge/screens/search/search_history.dart';
import 'package:paladinsedge/screens/search/search_list.dart';

class Search extends ConsumerStatefulWidget {
  static const routeName = '/search';

  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  String playerName = '';
  bool isLoading = false;
  bool _init = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      _init = false;
      ref.read(providers.players).getSearchHistory();
    }
    super.didChangeDependencies();
  }

  void onSearch(
    String playerName, {
    bool addInSeachHistory = true,
  }) async {
    setState(() => isLoading = true);

    final searchProvider = ref.read(providers.players);
    final exactMatch = await searchProvider.searchByName(
      playerName: playerName,
      simpleResults: false,
      addInSeachHistory: addInSeachHistory,
    );

    setState(() => isLoading = false);
    if (exactMatch) {
      Navigator.pushNamed(context, screens.PlayerDetail.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = ref.watch(providers.players);

    return CustomScrollView(
      slivers: [
        TopSearchBar(isLoading: isLoading, onSearch: onSearch),
        searchProvider.topSearchList.isNotEmpty
            ? const SearchList()
            : SearchHistory(
                playerName: playerName,
                onTap: (_playerName) {
                  playerName = _playerName;
                  onSearch(playerName, addInSeachHistory: false);
                },
              )
      ],
    );
  }
}
