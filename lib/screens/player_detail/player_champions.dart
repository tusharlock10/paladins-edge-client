import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class PlayerChampions extends HookConsumerWidget {
  const PlayerChampions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playerChampions = ref.watch(
      providers.champions.select((_) => _.playerChampions),
    );
    final championsProvider = ref.read(providers.champions);

    // State
    final _sortColumnIndex = useState(0);
    final _sortAscending = useState(true);

    // Variables
    final champions = championsProvider.champions;

    // Methods
    final sortChampionsByColumn = useCallback(
      (int columnIndex, void Function(bool) sortChampion) {
        _sortColumnIndex.value = columnIndex;
        _sortAscending.value = !_sortAscending.value;
        sortChampion(_sortAscending.value);
      },
      [],
    );

    final getKDAStyle = useCallback(
      (double kda) {
        if (kda > 3.8) {
          return const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          );
        }
        if (kda > 3) {
          return const TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          );
        }
        if (kda < 1) {
          return const TextStyle(
            color: Colors.red,
          );
        }
      },
      [],
    );

    final getWinRateStyle = useCallback(
      (double winRate) {
        if (winRate > 60) {
          return const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          );
        }
        if (winRate > 55) {
          return const TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          );
        }
        if (winRate < 42) {
          return const TextStyle(
            color: Colors.red,
          );
        }
      },
      [],
    );

    final getDataRow = useCallback(
      (models.PlayerChampion playerChampion) {
        final matches = playerChampion.losses + playerChampion.wins;
        final kills = playerChampion.totalKills;
        final deaths = playerChampion.totalDeaths;
        final winRate = playerChampion.wins * 100 / matches;
        final playTime = playerChampion.playTime / 60;
        final kda = (kills + playerChampion.totalAssists) / deaths;
        final level = playerChampion.level;
        final lastPlayed =
            utilities.getLastPlayedTime(playerChampion.lastPlayed);
        final champion = champions
            .firstWhere((_) => _.championId == playerChampion.championId);

        return DataRow(
          cells: [
            DataCell(
              widgets.ElevatedAvatar(
                imageUrl: champion.iconUrl,
                size: 18,
              ),
            ),
            DataCell(Text(matches.toString())),
            DataCell(Text(kills.toString())),
            DataCell(Text(deaths.toString())),
            DataCell(
              Text(
                kda.toStringAsPrecision(3),
                textAlign: TextAlign.center,
                style: getKDAStyle(kda),
              ),
            ),
            DataCell(
              Text(
                '${winRate.toStringAsPrecision(3)}%',
                style: getWinRateStyle(winRate),
              ),
            ),
            DataCell(Text(playTime.toStringAsPrecision(3))),
            DataCell(Text(level.toString())),
            DataCell(Text(lastPlayed)),
          ],
        );
      },
      [],
    );

    if (playerChampions == null) {
      return const Center(
        child: widgets.LoadingIndicator(
          size: 32,
        ),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: DataTable(
          sortColumnIndex: _sortColumnIndex.value,
          sortAscending: _sortAscending.value,
          columns: [
            DataColumn(
              label: const Text(
                'Champ',
                style: TextStyle(fontSize: 12),
              ),
              tooltip: 'Champion',
              onSort: (columnIndex, _) => sortChampionsByColumn(
                columnIndex,
                championsProvider.sortPlayerChampionsName,
              ),
            ),
            DataColumn(
              label: const Text('M'),
              tooltip: 'Total matches on this champion',
              numeric: true,
              onSort: (columnIndex, _) => sortChampionsByColumn(
                columnIndex,
                championsProvider.sortPlayerChampionsMatches,
              ),
            ),
            DataColumn(
              label: const Text('K'),
              tooltip: 'Total Kills',
              numeric: true,
              onSort: (columnIndex, _) => sortChampionsByColumn(
                columnIndex,
                championsProvider.sortPlayerChampionsKills,
              ),
            ),
            DataColumn(
              label: const Text('D'),
              tooltip: 'Total Deaths',
              numeric: true,
              onSort: (columnIndex, _) => sortChampionsByColumn(
                columnIndex,
                championsProvider.sortPlayerChampionsDeaths,
              ),
            ),
            DataColumn(
              label: const Text('KDA'),
              tooltip: 'Kills Deaths Assists',
              numeric: true,
              onSort: (columnIndex, _) => sortChampionsByColumn(
                columnIndex,
                championsProvider.sortPlayerChampionsKDA,
              ),
            ),
            DataColumn(
              label: const Text('WR'),
              tooltip: 'Win Rate',
              numeric: true,
              onSort: (columnIndex, _) => sortChampionsByColumn(
                columnIndex,
                championsProvider.sortPlayerChampionsWinRate,
              ),
            ),
            DataColumn(
              label: const Text('Hrs'),
              tooltip: 'Play time',
              numeric: true,
              onSort: (columnIndex, _) => sortChampionsByColumn(
                columnIndex,
                championsProvider.sortPlayerChampionsWinRate,
              ),
            ),
            DataColumn(
              label: const Text('Lvl'),
              tooltip: 'Level of the champion',
              numeric: true,
              onSort: (columnIndex, _) => sortChampionsByColumn(
                columnIndex,
                championsProvider.sortPlayerChampionsLevel,
              ),
            ),
            DataColumn(
              label: const Text('Last Played'),
              tooltip: 'Time passed since last played',
              onSort: (columnIndex, _) => sortChampionsByColumn(
                columnIndex,
                championsProvider.sortPlayerChampionsLastPlayed,
              ),
            ),
          ],
          rows: playerChampions.map(getDataRow).toList(),
        ),
      ),
    );
  }
}
