import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/screens/player_detail/player_detail_header.dart";
import "package:paladinsedge/screens/player_detail/player_detail_matches.dart";
import "package:paladinsedge/screens/player_detail/player_detail_menu.dart";
import "package:paladinsedge/widgets/index.dart" as widgets;

class PlayerDetail extends HookConsumerWidget {
  static const routeName = "player";
  static const routePath = "player/:playerId";
  final int playerId;

  const PlayerDetail({
    required this.playerId,
    Key? key,
  }) : super(key: key);

  static GoRoute goRouteBuilder(List<GoRoute> routes) => GoRoute(
        name: routeName,
        path: routePath,
        pageBuilder: _routeBuilder,
        routes: routes,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final matchesProvider = ref.read(providers.matches);
    final playersProvider = ref.read(providers.players);
    final championsProvider = ref.read(providers.champions);
    final player = ref.watch(providers.players.select((_) => _.playerData));
    final isLoadingPlayerData = ref.watch(
      providers.players.select((_) => _.isLoadingPlayerData),
    );
    final playerStatus = ref.watch(
      providers.players.select((_) => _.playerStatus),
    );
    final combinedMatchesPlayerId = ref.watch(
      providers.matches.select((_) => _.combinedMatchesPlayerId),
    );
    final playerChampionsPlayerId = ref.watch(
      providers.champions.select((_) => _.playerChampionsPlayerId),
    );
    final playerInferred = ref.watch(
      providers.players.select((_) => _.playerInferred),
    );

    // Variables
    final isSamePlayer = player?.playerId == playerId;
    final isSamePlayerStatus = playerStatus?.playerId == playerId;
    final isSamePlayerMatches = combinedMatchesPlayerId == playerId;
    final isSamePlayerChampions = playerChampionsPlayerId == playerId;
    final isSamePlayerInferred = playerInferred?.playerId == playerId;

    // Methods
    final getPlayerDetails = useCallback(
      ({bool forceUpdate = false}) async {
        matchesProvider.clearAppliedFiltersAndSort();
        if (!isSamePlayerMatches || forceUpdate) {
          matchesProvider.resetPlayerMatches(forceUpdate: forceUpdate);
        }
        await Future.wait([
          if (!isSamePlayer || forceUpdate)
            playersProvider.getPlayerData(
              playerId: playerId,
              forceUpdate: forceUpdate,
            ),
          if (!isSamePlayerStatus || forceUpdate)
            playersProvider.getPlayerStatus(
              playerId: playerId,
              onlyStatus: true,
              forceUpdate: forceUpdate,
            ),
        ]);

        await Future.wait([
          if (!isSamePlayerMatches || forceUpdate)
            matchesProvider.getPlayerMatches(
              playerId: playerId,
              forceUpdate: forceUpdate,
            ),
          if (!isSamePlayerChampions || forceUpdate)
            championsProvider.getPlayerChampions(
              playerId: playerId,
              forceUpdate: forceUpdate,
            ),
        ]);

        if (!isSamePlayerInferred || forceUpdate) {
          playersProvider.getPlayerInferred(playerId: playerId);
        }
      },
      [
        isSamePlayer,
        isSamePlayerStatus,
        isSamePlayerMatches,
        isSamePlayerChampions,
        playerId,
      ],
    );

    final onRefresh = useCallback(
      () {
        return getPlayerDetails(forceUpdate: true);
      },
      [playerId],
    );

    // Effects

    useEffect(
      () {
        getPlayerDetails();

        // reset the player and filters data in provider when unmounting
        return matchesProvider.clearAppliedFiltersAndSort;
      },
      [playerId],
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(
            child: widgets.RefreshButton(
              onRefresh: onRefresh,
              color: Colors.white,
            ),
          ),
          const PlayerDetailMenu(),
        ],
        title: isLoadingPlayerData || player == null
            ? const Text("Player")
            : Column(
                children: [
                  SelectableText(
                    player.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (player.title != null)
                    SelectableText(
                      player.title!,
                      style: const TextStyle(fontSize: 12),
                    ),
                ],
              ),
      ),
      body: isLoadingPlayerData
          ? const widgets.LoadingIndicator(
              lineWidth: 2,
              size: 28,
              center: true,
              label: Text("Loading player"),
            )
          : widgets.Refresh(
              onRefresh: onRefresh,
              child: Stack(
                children: const [
                  PlayerDetailMatches(),
                  PlayerDetailHeader(),
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

    return CupertinoPage(child: PlayerDetail(playerId: paramPlayerId));
  }
}
