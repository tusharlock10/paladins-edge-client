import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/screens/player_champions/player_champions_data_source.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PlayerChampions extends HookConsumerWidget {
  static const routeName = '/playerChampions';

  const PlayerChampions({Key? key}) : super(key: key);

  static BeamPage routeBuilder(
    BuildContext _,
    BeamState __,
    Object? ___,
  ) =>
      const BeamPage(
        title: 'Player Champs • Paladins Edge',
        child: PlayerChampions(),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final player = ref.watch(providers.players.select((_) => _.playerData));
    final playerChampions = ref.watch(
      providers.champions.select((_) => _.playerChampions),
    );
    final championsProvider = ref.read(providers.champions);

    // Variables
    final champions = championsProvider.champions;
    final headerTextStyle =
        Theme.of(context).textTheme.headline1?.copyWith(fontSize: 16);

    // State
    final _playerChampionsDataSource =
        useState<PlayerChampionsDataSource?>(null);

    // Methods
    final onLoadoutPress = useCallback(
      (models.Champion champion) {
        context.beamToNamed(
          screens.Loadouts.routeName,
          data: data_classes.LoadoutScreenArguments(
            champion: champion,
            player: player,
          ),
        );
      },
      [player],
    );

    // Effects
    useEffect(
      () {
        if (player == null || playerChampions == null) return null;

        _playerChampionsDataSource.value = PlayerChampionsDataSource(
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
            const Text('Player Champions'),
            if (player != null)
              Text(
                player.name,
                style: const TextStyle(fontSize: 12),
              ),
          ],
        ),
      ),
      body: _playerChampionsDataSource.value == null
          ? const Center(
              child: widgets.LoadingIndicator(
                lineWidth: 2,
                size: 28,
                label: Text('Getting champions'),
              ),
            )
          : SfDataGrid(
              allowSorting: true,
              rowHeight: 60,
              frozenColumnsCount: 1,
              source: _playerChampionsDataSource.value!,
              columnWidthMode: ColumnWidthMode.fitByColumnName,
              headerGridLinesVisibility: GridLinesVisibility.both,
              gridLinesVisibility: GridLinesVisibility.both,
              horizontalScrollPhysics: const ClampingScrollPhysics(),
              columns: [
                GridColumn(
                  columnName: 'Champ',
                  label: Center(
                    child: Text('Champ', style: headerTextStyle),
                  ),
                ),
                GridColumn(
                  columnName: 'Matches',
                  label: Center(
                    child: Text('Matches', style: headerTextStyle),
                  ),
                ),
                GridColumn(
                  columnName: 'Kills',
                  label: Center(
                    child: Text('Kills', style: headerTextStyle),
                  ),
                ),
                GridColumn(
                  columnName: 'Deaths',
                  label: Center(
                    child: Text('Deaths', style: headerTextStyle),
                  ),
                ),
                GridColumn(
                  columnName: 'KDA',
                  label: Center(
                    child: Text('KDA', style: headerTextStyle),
                  ),
                ),
                GridColumn(
                  columnName: 'Win Rate',
                  label: Center(
                    child: Text('Win Rate', style: headerTextStyle),
                  ),
                ),
                GridColumn(
                  columnName: 'Play Time',
                  width: 140,
                  autoFitPadding: const EdgeInsets.symmetric(horizontal: 10),
                  label: Center(
                    child: Text('Play Time', style: headerTextStyle),
                  ),
                ),
                GridColumn(
                  columnName: 'Level',
                  label: Center(
                    child: Text('Level', style: headerTextStyle),
                  ),
                ),
                GridColumn(
                  columnName: 'Last Played',
                  label: Center(
                    child: Text('Last Played', style: headerTextStyle),
                  ),
                ),
                GridColumn(
                  columnName: 'Loadouts',
                  allowSorting: false,
                  width: 160,
                  label: Center(
                    child: Text('Loadouts', style: headerTextStyle),
                  ),
                ),
              ],
            ),
    );
  }
}
