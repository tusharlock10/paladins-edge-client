import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PlyerChampionsDataSource extends DataGridSource {
  List<DataGridRow> _playerChampions = [];

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

    return null;
  }

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

    return null;
  }

  PlyerChampionsDataSource({
    required List<models.PlayerChampion> playerChampions,
    required List<models.Champion> champions,
  }) {
    _playerChampions = playerChampions.map<DataGridRow>((playerChampion) {
      final matches = playerChampion.losses + playerChampion.wins;
      final kills = playerChampion.totalKills;
      final deaths = playerChampion.totalDeaths;
      final winRate = playerChampion.wins * 100 / matches;
      final playTime = playerChampion.playTime / 60;
      final kda = (kills + playerChampion.totalAssists) / deaths;
      final level = playerChampion.level;
      final lastPlayed = utilities.getLastPlayedTime(playerChampion.lastPlayed);
      final champion = champions.firstOrNullWhere(
        (_) => _.championId == playerChampion.championId,
      );

      return DataGridRow(
        cells: [
          DataGridCell<Widget>(
            columnName: 'Champ',
            value: champion == null
                ? const SizedBox(height: 18 * 2, width: 18 * 2)
                : Expanded(
                    child: Center(
                      child: widgets.ElevatedAvatar(
                        imageUrl: champion.iconUrl,
                        size: 18,
                      ),
                    ),
                  ),
          ),
          DataGridCell<int>(columnName: 'Matches', value: matches),
          DataGridCell<int>(columnName: 'Kills', value: kills),
          DataGridCell<int>(columnName: 'Deaths', value: deaths),
          DataGridCell<Widget>(
            columnName: 'KDA',
            value: Text(
              kda.toStringAsPrecision(3),
              textAlign: TextAlign.center,
              style: getKDAStyle(kda),
            ),
          ),
          DataGridCell<Widget>(
            columnName: 'Win Rate',
            value: Text(
              '${winRate.toStringAsPrecision(3)}%',
              style: getWinRateStyle(winRate),
            ),
          ),
          DataGridCell(
            columnName: 'Play Time',
            value: playTime.toStringAsPrecision(3),
          ),
          DataGridCell(columnName: 'Level', value: level),
          DataGridCell(columnName: 'Last Played', value: lastPlayed),
        ],
      );
    }).toList();
  }

  final List<DataGridRow> _employees = [];

  @override
  List<DataGridRow> get rows => _employees;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (dataGridCell) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Text(dataGridCell.value.toString()),
          );
        },
      ).toList(),
    );
  }
}
