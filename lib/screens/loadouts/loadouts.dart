import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/screens/loadouts/loadout_item.dart";
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class Loadouts extends HookConsumerWidget {
  static const routeName = "loadouts";
  static const routePath = "loadouts/:playerId";
  final int championId;
  final String playerId;

  const Loadouts({
    required this.playerId,
    required this.championId,
    Key? key,
  }) : super(key: key);

  static GoRoute goRouteBuilder(List<GoRoute> routes) => GoRoute(
        name: routeName,
        path: routePath,
        builder: _routeBuilder,
        routes: routes,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final loadoutProvider = ref.read(providers.loadout);
    final championsProvider = ref.read(providers.champions);
    final playersProvider = ref.read(providers.players);
    final userPlayerId = ref.read(providers.auth).player?.playerId;
    final champions = ref.read(providers.champions).champions;
    final player = ref.watch(providers.players.select((_) => _.playerData));
    final loadouts = ref.watch(providers.loadout.select((_) => _.loadouts));
    final isGettingLoadouts = ref.watch(
      providers.loadout.select((_) => _.isGettingLoadouts),
    );
    final isLoadingPlayerData = ref.watch(
      providers.players.select((_) => _.isLoadingPlayerData),
    );
    final isLoadingCombinedChampions = ref.watch(
      providers.champions.select((_) => _.isLoadingCombinedChampions),
    );

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final champion = champions.firstOrNullWhere(
      (_) => _.championId == championId,
    );
    final isOtherPlayer = userPlayerId != playerId;

    final crossAxisCount = utilities.responsiveCondition(
      context,
      desktop: 2,
      tablet: 2,
      mobile: 1,
    );
    final double horizontalPadding = utilities.responsiveCondition(
      context,
      desktop: 30,
      tablet: 30,
      mobile: 10,
    );

    // State
    final hideLoadoutFab = useState(false);

    // Effects
    useEffect(
      () {
        // check if champions exists,
        // if not, then get champions
        if (champion == null) {
          championsProvider.loadCombinedChampions(false);
        }

        return;
      },
      [],
    );

    useEffect(
      () {
        // check if player exists,
        // if not, then get player
        if (player == null) {
          playersProvider.getPlayerData(
            playerId: playerId,
            forceUpdate: false,
          );
        }

        return;
      },
      [],
    );

    useEffect(
      () {
        loadoutProvider.getPlayerLoadouts(
          playerId: playerId,
          championId: championId,
        );

        return loadoutProvider.resetPlayerLoadouts;
      },
      [],
    );

    // Methods
    final onCreate = useCallback(
      () {
        if (isOtherPlayer) return;
        loadoutProvider.createDraftLoadout(
          championId: championId,
          playerId: playerId,
          loadout: null,
        );
        utilities.Navigation.navigate(
          context,
          screens.CreateLoadout.routeName,
          params: {
            "championId": championId.toString(),
            "playerId": playerId,
          },
        );
      },
      [isOtherPlayer],
    );

    final onEdit = useCallback(
      (models.Loadout loadout) {
        final loadoutHash = loadout.loadoutHash;
        if (isOtherPlayer || loadoutHash == null) return;
        loadoutProvider.createDraftLoadout(
          championId: championId,
          playerId: playerId,
          loadout: loadout,
        );
        utilities.Navigation.navigate(
          context,
          screens.CreateLoadout.routeName,
          params: {
            "championId": championId.toString(),
            "playerId": playerId,
          },
        );
      },
      [isOtherPlayer],
    );

    final onRefresh = useCallback(
      () async {
        if (champion != null) {
          return await loadoutProvider.getPlayerLoadouts(
            playerId: playerId,
            championId: champion.championId,
            forceUpdate: true,
          );
        }
      },
      [playerId],
    );

    return Scaffold(
      floatingActionButton: isOtherPlayer
          ? null
          : SizedBox(
              height: 40,
              width: 90,
              child: AnimatedSlide(
                offset: hideLoadoutFab.value
                    ? const Offset(0, 2)
                    : const Offset(0, 0),
                duration: const Duration(milliseconds: 250),
                child: FloatingActionButton(
                  onPressed: onCreate,
                  elevation: 4,
                  hoverElevation: 6,
                  focusElevation: 8,
                  backgroundColor: theme.themeMaterialColor,
                  isExtended: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add,
                        size: 18,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "Create",
                        style: textTheme.bodyText2?.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
            ),
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
              title: Column(
                children: [
                  Text(isOtherPlayer ? "Loadouts" : "Your Loadouts"),
                  if (champion != null && player != null)
                    Text(
                      isOtherPlayer
                          ? "${player.name} - ${champion.name}"
                          : champion.name,
                      style: const TextStyle(fontSize: 12),
                    ),
                ],
              ),
            ),
            loadouts != null && loadouts.isNotEmpty && champion != null
                ? SliverPadding(
                    padding: EdgeInsets.only(
                      right: horizontalPadding,
                      left: horizontalPadding,
                      top: 20,
                      bottom: 70,
                    ),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: LoadoutItem.loadoutAspectRatio,
                        mainAxisSpacing: 5,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (_, index) {
                          final loadout = loadouts[index];

                          return GestureDetector(
                            onTap: loadout.isImported
                                ? null
                                : () => onEdit(loadout),
                            child: AbsorbPointer(
                              absorbing: !loadout.isImported,
                              child: LoadoutItem(
                                loadout: loadout,
                                champion: champion,
                              ),
                            ),
                          );
                        },
                        childCount: loadouts.length,
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        SizedBox(
                          height: utilities.getBodyHeight(context),
                          child: isGettingLoadouts ||
                                  isLoadingCombinedChampions ||
                                  isLoadingPlayerData
                              ? const widgets.LoadingIndicator(
                                  lineWidth: 2,
                                  size: 28,
                                  label: Text("Getting loadouts"),
                                )
                              : loadouts != null &&
                                      champion != null &&
                                      loadouts.isEmpty
                                  ? Center(
                                      child: Text(
                                        "No loadouts found for ${champion.name}",
                                      ),
                                    )
                                  : const Center(
                                      child: Text("Unable to fetch loadouts"),
                                    ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  static Widget _routeBuilder(_, GoRouterState state) {
    final paramChampionId = state.params["championId"];
    final paramPlayerId = state.params["playerId"];
    if (paramChampionId == null || paramPlayerId == null) {
      return const screens.NotFound();
    }

    final championId = int.tryParse(paramChampionId);
    if (championId == null) return const screens.NotFound();

    if (int.tryParse(paramPlayerId) == null) return const screens.NotFound();
    final playerId = paramPlayerId;

    return Loadouts(playerId: playerId, championId: championId);
  }
}
