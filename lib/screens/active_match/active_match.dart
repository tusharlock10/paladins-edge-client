import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/active_match/active_match_list.dart";
import "package:paladinsedge/screens/active_match/active_match_loading.dart";
import "package:paladinsedge/screens/active_match/active_match_not_in_match.dart";
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class ActiveMatch extends HookConsumerWidget {
  static const routeName = "active-match";
  static const routePath = "active-match";
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    pageBuilder: _routeBuilder,
  );
  static const userRouteName = "user-active-match";
  static const userRoutePath = "active-match";
  static final userGoRoute = GoRoute(
    name: userRouteName,
    path: userRoutePath,
    pageBuilder: _userRouteBuilder,
    redirect: utilities.Navigation.protectedRouteRedirect,
  );
  final String? playerId;

  const ActiveMatch({
    this.playerId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final championsProvider = ref.read(providers.champions);
    final userPlayer = ref.watch(providers.auth.select((_) => _.userPlayer));
    final playerStatusPlayerId = playerId ?? userPlayer?.playerId;

    final playerNotifier = providers.players(playerStatusPlayerId!);
    final playerProvider = ref.read(playerNotifier);
    final isLoadingPlayerStatus = ref.watch(
      playerNotifier.select((_) => _.isLoadingPlayerStatus),
    );
    final playerStatus = ref.watch(
      playerNotifier.select((_) => _.playerStatus),
    );

    // Variables
    final isUserPlayer = userPlayer?.playerId == playerStatusPlayerId;

    // State
    final isRefreshing = useState(false);

    // Effects
    useEffect(
      () {
        playerProvider.getPlayerStatus();

        return null;
      },
      [],
    );

    useEffect(
      () {
        if (playerStatus != null &&
            playerStatus.match != null &&
            playerStatus.match?.playersInfo != null) {
          final playerChampionsQuery =
              playerStatus.match!.playersInfo.map((item) {
            return data_classes.BatchPlayerChampionsPayload(
              championId: item.championId,
              playerId: item.player.playerId,
            );
          }).toList();

          championsProvider.getPlayerChampionsBatch(playerChampionsQuery);
        }

        return null;
      },
      [playerStatus],
    );

    // Methods
    final onRefresh = useCallback(
      () async {
        isRefreshing.value = true;
        await playerProvider.getPlayerStatus(forceUpdate: true);
        isRefreshing.value = false;
      },
      [],
    );

    return Scaffold(
      body: widgets.Refresh(
        edgeOffset: utilities.getTopEdgeOffset(context),
        onRefresh: onRefresh,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              forceElevated: true,
              floating: true,
              snap: true,
              pinned: !constants.isMobile,
              title: const Text("Active Match"),
              actions: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: widgets.RefreshButton(
                      color: Colors.white,
                      onRefresh: onRefresh,
                      isRefreshing: isRefreshing.value,
                    ),
                  ),
                ),
              ],
            ),
            playerStatus == null
                ? ActiveMatchLoading(
                    isLoadingPlayerStatus: isLoadingPlayerStatus,
                    isUserPlayer: isUserPlayer,
                  )
                : playerStatus.match == null
                    ? ActiveMatchNotInMatch(
                        status: playerStatus.status,
                        isUserPlayer: isUserPlayer,
                      )
                    : ActiveMatchList(playerId: playerStatusPlayerId),
          ],
        ),
      ),
    );
  }

  static Page _routeBuilder(_, GoRouterState state) {
    final paramPlayerId = state.pathParameters["playerId"];
    if (paramPlayerId == null) {
      return const CupertinoPage(child: screens.NotFound());
    }

    if (int.tryParse(paramPlayerId) == null) {
      return const CupertinoPage(child: screens.NotFound());
    }
    final playerId = paramPlayerId;

    return CupertinoPage(
      child: widgets.PopShortcut(child: ActiveMatch(playerId: playerId)),
    );
  }

  static Page _userRouteBuilder(_, __) => const CupertinoPage(
        child: widgets.PopShortcut(child: ActiveMatch()),
      );
}
