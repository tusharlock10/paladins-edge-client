import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
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
  final String playerId;

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
    final playerStreak = ref.watch(
      providers.matches.select((_) => _.playerStreak),
    );

    // Variables
    final isSamePlayer = player?.playerId == playerId;
    final isSamePlayerStatus = playerStatus?.playerId == playerId;
    final isSamePlayerMatches = combinedMatchesPlayerId == playerId;
    final isSamePlayerChampions = playerChampionsPlayerId == playerId;
    final isSamePlayerInferred = playerInferred?.playerId == playerId;

    // State
    final isRefreshing = useState(false);

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
      () async {
        isRefreshing.value = true;
        await getPlayerDetails(forceUpdate: true);
        isRefreshing.value = false;
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: widgets.RefreshButton(
                onRefresh: onRefresh,
                color: Colors.white,
                isRefreshing: isRefreshing.value,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 5),
            child: PlayerDetailMenu(),
          ),
        ],
        title: isLoadingPlayerData || player == null
            ? const Text("Player")
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: playerStreak == null
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                  if (playerStreak != null)
                    widgets.TextChip(
                      iconSize: 18,
                      textSize: 14,
                      icon: playerStreak.isNegative
                          ? FeatherIcons.arrowDownCircle
                          : FeatherIcons.arrowUpCircle,
                      color:
                          playerStreak.isNegative ? Colors.red : Colors.green,
                      text:
                          "${playerStreak.abs()} ${playerStreak.isNegative ? 'loose' : 'win'} streak",
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
              child: const Stack(
                children: [
                  PlayerDetailMatches(),
                  PlayerDetailHeader(),
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
      child: widgets.PopShortcut(child: PlayerDetail(playerId: playerId)),
    );
  }
}
