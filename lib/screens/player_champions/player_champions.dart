import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/player_champions/player_champions_data_source.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PlayerChampions extends HookConsumerWidget {
  static const routeName = '/playerChampions';

  const PlayerChampions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playerChampions = ref.watch(
      providers.champions.select((_) => _.playerChampions),
    );
    final championsProvider = ref.read(providers.champions);

    // Variables
    final champions = championsProvider.champions;

    // State
    final _playerChampionsDataSource =
        useState<PlayerChampionsDataSource?>(null);

    // Effects
    useEffect(
      () {
        if (playerChampions == null) return null;

        _playerChampionsDataSource.value = PlayerChampionsDataSource(
          champions: champions,
          playerChampions: playerChampions,
        );

        return null;
      },
      [playerChampions],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Champions'),
      ),
      body: _playerChampionsDataSource.value == null
          ? const Center(
              child: widgets.LoadingIndicator(
                size: 32,
              ),
            )
          : SfDataGrid(
              allowSorting: true,
              rowHeight: 60,
              source: _playerChampionsDataSource.value!,
              columnWidthMode: ColumnWidthMode.fitByColumnName,
              headerGridLinesVisibility: GridLinesVisibility.both,
              gridLinesVisibility: GridLinesVisibility.both,
              columns: [
                GridColumn(
                  columnName: 'Champ',
                  label: const Center(
                    child: Text('Champs'),
                  ),
                ),
                GridColumn(
                  columnName: 'Matches',
                  label: const Center(
                    child: Text('Matches'),
                  ),
                ),
                GridColumn(
                  columnName: 'Kills',
                  label: const Center(
                    child: Text('Kills'),
                  ),
                ),
                GridColumn(
                  columnName: 'Deaths',
                  label: const Center(
                    child: Text('Deaths'),
                  ),
                ),
                GridColumn(
                  columnName: 'KDA',
                  label: const Center(
                    child: Text('KDA'),
                  ),
                ),
                GridColumn(
                  columnName: 'Win Rate',
                  label: const Center(
                    child: Text('Win Rate'),
                  ),
                ),
                GridColumn(
                  columnName: 'Play Time',
                  autoFitPadding: const EdgeInsets.symmetric(horizontal: 10),
                  label: const Center(
                    child: Text('Play Time'),
                  ),
                ),
                GridColumn(
                  columnName: 'Level',
                  label: const Center(
                    child: Text('Level'),
                  ),
                ),
                GridColumn(
                  columnName: 'Last Played',
                  label: const Center(
                    child: Text('Last Played'),
                  ),
                ),
              ],
            ),
    );
  }
}
