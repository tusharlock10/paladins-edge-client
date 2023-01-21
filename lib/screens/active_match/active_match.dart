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
  final int? playerId;

  const ActiveMatch({
    this.playerId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playersProvider = ref.read(providers.players);
    final championsProvider = ref.read(providers.champions);
    final player = ref.watch(providers.auth.select((_) => _.player));
    final isLoadingPlayerStatus = ref.watch(
      providers.players.select((_) => _.isLoadingPlayerStatus),
    );
    final playerStatus = ref.watch(
      providers.players.select((_) => _.playerStatus),
    );

    // Variables
    final playerStatusPlayerId = playerId ?? player?.playerId;
    final isUserPlayer = player?.playerId == playerStatusPlayerId;

    // Effects
    useEffect(
      () {
        if (playerStatusPlayerId != null) {
          playersProvider.getPlayerStatus(playerId: playerStatusPlayerId);
        }

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
        if (playerStatusPlayerId != null) {
          return playersProvider.getPlayerStatus(
            playerId: playerStatusPlayerId,
            forceUpdate: true,
          );
        }
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
              pinned: constants.isWeb,
              title: const Text("Active Match"),
              actions: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: widgets.RefreshButton(
                      color: Colors.white,
                      onRefresh: onRefresh,
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
                    : const ActiveMatchList(),
          ],
        ),
      ),
    );
  }

  static Page _routeBuilder(_, GoRouterState state) {
    final paramPlayerId = int.tryParse(state.params["playerId"] ?? "");
    if (paramPlayerId == null) {
      return const CupertinoPage(child: screens.NotFound());
    }

    return CupertinoPage(child: ActiveMatch(playerId: paramPlayerId));
  }

  static Page _userRouteBuilder(_, __) =>
      const CupertinoPage(child: ActiveMatch());
}
