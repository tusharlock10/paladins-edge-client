import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/screens/player_champions/player_champions_data_source.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;
import "package:syncfusion_flutter_datagrid/datagrid.dart";

class PlayerChampions extends HookConsumerWidget {
  static const routeName = "player-champions";
  static const routePath = "player-champions";
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    pageBuilder: _routeBuilder,
  );
  final String playerId;

  const PlayerChampions({
    required this.playerId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playersProvider = ref.read(providers.players);
    final player = ref.watch(providers.players.select((_) => _.playerData));
    final playerChampions = ref.watch(
      providers.champions.select((_) => _.playerChampions),
    );
    final championsProvider = ref.read(providers.champions);

    // Variables
    final champions = championsProvider.champions;
    final headerTextStyle =
        Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 16);

    // State
    final playerChampionsDataSource =
        useState<PlayerChampionsDataSource?>(null);

    // Effects
    useEffect(
      () {
        // if player is null, get it from server
        if (player == null) {
          playersProvider.getPlayerData(
            playerId: playerId,
            forceUpdate: false,
          );
        }

        return;
      },
      [player],
    );

    // Methods
    final onLoadoutPress = useCallback(
      (models.Champion champion) {
        if (player == null) return;

        utilities.Analytics.logEvent(
          constants.AnalyticsEvent.otherPlayerViewLoadout,
          {"champion": champion.name},
        );
        utilities.Navigation.navigate(
          context,
          screens.Loadouts.routeName,
          params: {
            "championId": champion.championId.toString(),
            "playerId": player.playerId,
          },
        );
      },
      [player],
    );

    // Effects
    useEffect(
      () {
        if (player == null || playerChampions == null) return null;

        playerChampionsDataSource.value = PlayerChampionsDataSource(
          player: player,
          onLoadoutPress: onLoadoutPress,
          champions: champions,
          playerChampions: playerChampions,
        );

        return null;
      },
      [playerChampions],
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text("Player Champions"),
            if (player != null)
              SelectableText(
                player.name,
                style: const TextStyle(fontSize: 12),
              ),
          ],
        ),
      ),
      body: playerChampionsDataSource.value == null
          ? const Center(
              child: widgets.LoadingIndicator(
                lineWidth: 2,
                size: 28,
                label: Text("Getting champions"),
              ),
            )
          : SfDataGrid(
              allowSorting: true,
              rowHeight: 60,
              frozenColumnsCount: 1,
              source: playerChampionsDataSource.value!,
              columnWidthMode: ColumnWidthMode.fitByColumnName,
              headerGridLinesVisibility: GridLinesVisibility.both,
              gridLinesVisibility: GridLinesVisibility.both,
              horizontalScrollPhysics: const ClampingScrollPhysics(),
              columns: [
                GridColumn(
                  columnName: "Champ",
                  label: Center(
                    child: Text("Champ", style: headerTextStyle),
                  ),
                ),
                GridColumn(
                  columnName: "Matches",
                  label: Center(
                    child: Text("Matches", style: headerTextStyle),
                  ),
                ),
                GridColumn(
                  columnName: "Kills",
                  label: Center(
                    child: Text("Kills", style: headerTextStyle),
                  ),
                ),
                GridColumn(
                  columnName: "Deaths",
                  label: Center(
                    child: Text("Deaths", style: headerTextStyle),
                  ),
                ),
                GridColumn(
                  columnName: "KDA",
                  label: Center(
                    child: Text("KDA", style: headerTextStyle),
                  ),
                ),
                GridColumn(
                  columnName: "Win Rate",
                  label: Center(
                    child: Text("Win Rate", style: headerTextStyle),
                  ),
                ),
                GridColumn(
                  columnName: "Play Time",
                  width: 140,
                  autoFitPadding: const EdgeInsets.symmetric(horizontal: 10),
                  label: Center(
                    child: Text("Play Time", style: headerTextStyle),
                  ),
                ),
                GridColumn(
                  columnName: "Level",
                  label: Center(
                    child: Text("Level", style: headerTextStyle),
                  ),
                ),
                GridColumn(
                  columnName: "Last Played",
                  label: Center(
                    child: Text("Last Played", style: headerTextStyle),
                  ),
                ),
                GridColumn(
                  columnName: "Loadouts",
                  allowSorting: false,
                  width: 160,
                  label: Center(
                    child: Text("Loadouts", style: headerTextStyle),
                  ),
                ),
              ],
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

    return CupertinoPage(child: PlayerChampions(playerId: playerId));
  }
}
