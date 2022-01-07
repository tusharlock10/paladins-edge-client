import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class PlayerChampions extends HookConsumerWidget {
  const PlayerChampions({Key? key}) : super(key: key);

  TextStyle? getKDAStyle(double kda) {
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
  }

  TextStyle? getWinRateStyle(double winRate) {
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
  }

  DataRow getDataRow(
    models.Champion champion,
    models.PlayerChampion playerChampion,
  ) {
    final matches = playerChampion.losses + playerChampion.wins;
    final kills = playerChampion.totalKills;
    final deaths = playerChampion.totalDeaths;
    final winRate = playerChampion.wins * 100 / matches;
    final playTime = playerChampion.playTime / 60;
    final kda = (kills + playerChampion.totalAssists) / deaths;
    final level = playerChampion.level;
    final lastPlayed = utilities.getLastPlayedTime(playerChampion.lastPlayed);

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
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _sortColumnIndex = useState(0);
    final _sortAscending = useState(true);

    final playerChampions = ref.watch(
      providers.champions.select((_) => _.playerChampions),
    );

    final championsProvider = ref.read(providers.champions);
    final champions = championsProvider.champions;

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
              onSort: (columnIndex, _) {
                _sortColumnIndex.value = columnIndex;
                _sortAscending.value = !_sortAscending.value;
                championsProvider.sortPlayerChampionsName(_sortAscending.value);
              },
            ),
            DataColumn(
              label: const Text('M'),
              tooltip: 'Total matches on this champion',
              numeric: true,
              onSort: (columnIndex, _) {
                _sortColumnIndex.value = columnIndex;
                _sortAscending.value = !_sortAscending.value;
                championsProvider
                    .sortPlayerChampionsMatches(_sortAscending.value);
              },
            ),
            DataColumn(
              label: const Text('K'),
              tooltip: 'Total Kills',
              numeric: true,
              onSort: (columnIndex, _) {
                _sortColumnIndex.value = columnIndex;
                _sortAscending.value = !_sortAscending.value;
                championsProvider
                    .sortPlayerChampionsKills(_sortAscending.value);
              },
            ),
            DataColumn(
              label: const Text('D'),
              tooltip: 'Total Deaths',
              numeric: true,
              onSort: (columnIndex, _) {
                _sortColumnIndex.value = columnIndex;
                _sortAscending.value = !_sortAscending.value;
                championsProvider
                    .sortPlayerChampionsDeaths(_sortAscending.value);
              },
            ),
            DataColumn(
              label: const Text('KDA'),
              tooltip: 'Kills Deaths Assists',
              numeric: true,
              onSort: (columnIndex, _) {
                _sortColumnIndex.value = columnIndex;
                _sortAscending.value = !_sortAscending.value;
                championsProvider.sortPlayerChampionsKDA(_sortAscending.value);
              },
            ),
            DataColumn(
              label: const Text('WR'),
              tooltip: 'Win Rate',
              numeric: true,
              onSort: (columnIndex, _) {
                _sortColumnIndex.value = columnIndex;
                _sortAscending.value = !_sortAscending.value;
                championsProvider
                    .sortPlayerChampionsWinRate(_sortAscending.value);
              },
            ),
            DataColumn(
              label: const Text('Hrs'),
              tooltip: 'Play time',
              numeric: true,
              onSort: (columnIndex, _) {
                _sortColumnIndex.value = columnIndex;
                _sortAscending.value = !_sortAscending.value;
                championsProvider
                    .sortPlayerChampionsWinRate(_sortAscending.value);
              },
            ),
            DataColumn(
              label: const Text('Lvl'),
              tooltip: 'Level of the champion',
              numeric: true,
              onSort: (columnIndex, _) {
                _sortColumnIndex.value = columnIndex;
                _sortAscending.value = !_sortAscending.value;
                championsProvider
                    .sortPlayerChampionsLevel(_sortAscending.value);
              },
            ),
            DataColumn(
              label: const Text('Last Played'),
              tooltip: 'Time passed since last played',
              onSort: (columnIndex, _) {
                _sortColumnIndex.value = columnIndex;
                _sortAscending.value = !_sortAscending.value;
                championsProvider
                    .sortPlayerChampionsLastPlayed(_sortAscending.value);
              },
            ),
          ],
          rows: playerChampions.map(
            (playerChampion) {
              final champion = champions
                  .firstWhere((_) => _.championId == playerChampion.championId);

              return getDataRow(champion, playerChampion);
            },
          ).toList(),
        ),
      ),
    );
  }
}
