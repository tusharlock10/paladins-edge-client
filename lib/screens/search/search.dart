import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/screens/search/search_app_bar.dart";
import "package:paladinsedge/screens/search/search_history.dart";
import "package:paladinsedge/screens/search/search_lower_list.dart";
import "package:paladinsedge/screens/search/search_top_list.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class Search extends HookConsumerWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playersProvider = ref.read(providers.players);
    final topSearchList =
        ref.watch(providers.players.select((_) => _.topSearchList));
    final lowerSearchList =
        ref.watch(providers.players.select((_) => _.lowerSearchList));
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));

    // State
    final isLoading = useState(false);

    // Methods
    final navigateToPlayerDetail = useCallback(
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

    final onNotFound = useCallback(
      (String playerName) {
        widgets.showToast(
          context: context,
          text: "Player $playerName not found",
          type: widgets.ToastType.info,
        );
      },
      [],
    );

    final onSearch = useCallback(
      (
        String playerName, {
        bool addInSearchHistory = true,
      }) async {
        playerName = playerName.trim();
        if (playerName.isEmpty) return;

        isLoading.value = true;

        final response = await playersProvider.searchByName(
          playerName: playerName,
          simpleResults: false,
          addInSearchHistory: addInSearchHistory && !isGuest,
          onNotFound: onNotFound,
        );

        isLoading.value = false;

        if (response != null && response.exactMatch) {
          navigateToPlayerDetail(response.playerData!.playerId);
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
        topSearchList.isNotEmpty
            ? const SearchTopList()
            : const SearchHistory(),
        if (lowerSearchList.isNotEmpty) const SearchLowerList(),
      ],
    );
  }
}
