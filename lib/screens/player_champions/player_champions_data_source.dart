import 'package:dartx/dartx.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PlayerChampionsDataSource extends DataGridSource {
  List<DataGridRow> _playerChampions = [];

  @override
  List<DataGridRow> get rows => _playerChampions;

  PlayerChampionsDataSource({
    required List<models.PlayerChampion> playerChampions,
    required List<models.Champion> champions,
  }) {
    _playerChampions = playerChampions.mapNotNull(
      (playerChampion) {
        final matches = playerChampion.losses + playerChampion.wins;
        final kills = playerChampion.totalKills;
        final deaths = playerChampion.totalDeaths;
        final winRate = playerChampion.wins * 100 / matches;
        final kda = (kills + playerChampion.totalAssists) / deaths;
        final level = playerChampion.level;
        final playTime = playerChampion.playTime;
        final lastPlayed = playerChampion.lastPlayed;
        final championIndex = champions.indexWhere(
          (_) => _.championId == playerChampion.championId,
        );
        if (championIndex == -1) return null;

        final champion = champions[championIndex];

        return DataGridRow(
          cells: [
            DataGridCell(
              columnName: 'Champ',
              value: data_classes.PlayerChampionsSortData(
                iconUrl: champion.iconUrl,
                sortedIndex: championIndex,
                iconBlurHash: champion.iconBlurHash,
              ),
            ),
            DataGridCell(columnName: 'Matches', value: matches),
            DataGridCell(columnName: 'Kills', value: kills),
            DataGridCell(columnName: 'Deaths', value: deaths),
            DataGridCell(columnName: 'KDA', value: kda),
            DataGridCell(columnName: 'Win Rate', value: winRate),
            DataGridCell(columnName: 'Play Time', value: playTime),
            DataGridCell(columnName: 'Level', value: level),
            DataGridCell(columnName: 'Last Played', value: lastPlayed),
          ],
        );
      },
    ).toList();
  }

  TextStyle getWinRateStyle(double winRate) {
    if (winRate > 60) {
      return const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
        fontSize: 16,
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
        fontSize: 15,
      );
    }

    return const TextStyle(fontSize: 14);
  }

  TextStyle getKDAStyle(double kda) {
    if (kda > 3.8) {
      return const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
        fontSize: 16,
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
        fontSize: 15,
      );
    }

    return const TextStyle(fontSize: 14);
  }

  // ignore: long-method
  Widget getCellWidget(DataGridCell dataGridCell) {
    switch (dataGridCell.columnName) {
      case 'Champ':
        final sortedData =
            dataGridCell.value as data_classes.PlayerChampionsSortData;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widgets.ElevatedAvatar(
              imageUrl: sortedData.iconUrl,
              imageBlurHash: sortedData.iconBlurHash,
              size: 22,
            ),
          ],
        );
      case 'KDA':
        return Center(
          child: Text(
            dataGridCell.value.toStringAsPrecision(3) as String,
            style: getKDAStyle(dataGridCell.value as double),
          ),
        );
      case 'Win Rate':
        return Center(
          child: Text(
            '${dataGridCell.value.toStringAsPrecision(3)}%',
            style: getWinRateStyle(dataGridCell.value as double),
          ),
        );
      case 'Play Time':
        final playTime = Duration(minutes: dataGridCell.value as int);
        final humanizedTime = printDuration(
          playTime,
          abbreviated: true,
          upperTersity: DurationTersity.day,
        );
        return Center(child: Text(humanizedTime));
      case 'Last Played':
        return Center(
          child: Text(
            utilities.getLastPlayedTime(
              dataGridCell.value as DateTime,
              shortFormat: true,
            ),
          ),
        );
    }

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Text(dataGridCell.value.toString()),
      ),
    );
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map(getCellWidget).toList(),
    );
  }
}
