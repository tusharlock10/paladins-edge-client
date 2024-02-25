import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;
import "package:syncfusion_flutter_datagrid/datagrid.dart";
import "package:touchable_opacity/touchable_opacity.dart";

class PlayerChampionsDataSource extends DataGridSource {
  final models.Player player;
  final void Function(models.Champion) onLoadoutPress;
  final fontFamily = theme.Fonts.primaryAccent;
  List<DataGridRow> _playerChampions = [];

  @override
  List<DataGridRow> get rows => _playerChampions;

  PlayerChampionsDataSource({
    required this.player,
    required this.onLoadoutPress,
    required List<models.PlayerChampion> playerChampions,
    required List<models.Champion> champions,
  }) {
    _playerChampions = playerChampions.mapNotNull(
      (playerChampion) {
        final kills = playerChampion.totalKills;
        final deaths = playerChampion.totalDeaths;
        final winRate = playerChampion.winRate;
        final matches = playerChampion.matches;
        final kda = playerChampion.kda;
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
              columnName: "Champ",
              value: data_classes.PlayerChampionsSortData(
                championId: champion.championId,
                iconUrl: champion.iconUrl,
                sortedIndex: championIndex,
                iconBlurHash: champion.iconBlurHash,
                name: champion.name,
              ),
            ),
            DataGridCell(columnName: "Matches", value: matches),
            DataGridCell(columnName: "Kills", value: kills),
            DataGridCell(columnName: "Deaths", value: deaths),
            DataGridCell(columnName: "KDA", value: kda),
            DataGridCell(columnName: "Win Rate", value: winRate),
            DataGridCell(columnName: "Play Time", value: playTime),
            DataGridCell(columnName: "Level", value: level),
            DataGridCell(columnName: "Last Played", value: lastPlayed),
            DataGridCell(columnName: "Loadout", value: champion),
          ],
        );
      },
    ).toList();
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map(_getCellWidget).toList(),
    );
  }

  Widget _getChampCellWidget(DataGridCell dataGridCell) {
    final sortedData =
        dataGridCell.value as data_classes.PlayerChampionsSortData;

    var championIcon = data_classes.PlatformOptimizedImage(
      imageUrl: utilities.getSmallAsset(sortedData.iconUrl),
      blurHash: sortedData.iconBlurHash,
      assetType: constants.ChampionAssetType.icons,
      assetId: sortedData.championId,
    );

    return Center(
      child: widgets.ElevatedAvatar(
        imageUrl: championIcon.optimizedUrl,
        imageBlurHash: championIcon.blurHash,
        isAssetImage: championIcon.isAssetImage,
        size: 22,
      ),
    );
  }

  Widget _getMatchesCellWidget(DataGridCell dataGridCell) {
    return Center(
      child: Text(
        dataGridCell.value.toString(),
        style: TextStyle(fontFamily: fontFamily),
      ),
    );
  }

  Widget _getKillsCellWidget(DataGridCell dataGridCell) {
    return Center(
      child: Text(
        dataGridCell.value.toString(),
        style: TextStyle(fontFamily: fontFamily),
      ),
    );
  }

  Widget _getDeathsCellWidget(DataGridCell dataGridCell) {
    return Center(
      child: Text(
        dataGridCell.value.toString(),
        style: TextStyle(fontFamily: fontFamily),
      ),
    );
  }

  Widget _getKDACellWidget(DataGridCell dataGridCell) {
    final value = dataGridCell.value as double;
    final kdaFormatted = value.toStringAsPrecision(3);
    final kdaColor = utilities.getKDAColor(value);

    return Center(
      child: Text(
        kdaFormatted,
        style: TextStyle(color: kdaColor),
      ),
    );
  }

  Widget _getWinRateCellWidget(DataGridCell dataGridCell) {
    final value = (dataGridCell.value as double) * 100;
    final winRateFormatted = value.toStringAsPrecision(3);
    final winRateColor = utilities.getWinRateColor(value);

    return Center(
      child: Text(
        "$winRateFormatted%",
        style: TextStyle(color: winRateColor),
      ),
    );
  }

  Widget _getPlayTimeCellWidget(DataGridCell dataGridCell) {
    final humanizedTime =
        utilities.getFormattedPlayTime(dataGridCell.value as int);

    return Center(
      child: Text(
        humanizedTime,
        style: TextStyle(fontFamily: fontFamily),
      ),
    );
  }

  Widget _getLevelCellWidget(DataGridCell dataGridCell) {
    return Center(
      child: Text(
        dataGridCell.value.toString(),
        style: TextStyle(fontFamily: fontFamily),
      ),
    );
  }

  Widget _getLastPlayedCellWidget(DataGridCell dataGridCell) {
    return Center(
      child: Text(
        utilities.getLastPlayedTime(
          dataGridCell.value as DateTime,
          shortFormat: true,
        ),
        style: TextStyle(fontFamily: fontFamily),
      ),
    );
  }

  Widget _getLoadoutCellWidget(DataGridCell dataGridCell) {
    final champion = dataGridCell.value as models.Champion;

    return TouchableOpacity(
      onTap: () => onLoadoutPress(champion),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Check loadouts",
              style: TextStyle(
                color: theme.themeMaterialColor,
                fontFamily: fontFamily,
                decoration: TextDecoration.underline,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 5),
            const Icon(
              FeatherIcons.arrowRight,
              color: theme.themeMaterialColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // ignore: long-method
  Widget _getCellWidget(DataGridCell dataGridCell) {
    switch (dataGridCell.columnName) {
      case "Champ":
        return _getChampCellWidget(dataGridCell);
      case "Matches":
        return _getMatchesCellWidget(dataGridCell);
      case "Kills":
        return _getKillsCellWidget(dataGridCell);
      case "Deaths":
        return _getDeathsCellWidget(dataGridCell);
      case "KDA":
        return _getKDACellWidget(dataGridCell);
      case "Win Rate":
        return _getWinRateCellWidget(dataGridCell);
      case "Play Time":
        return _getPlayTimeCellWidget(dataGridCell);
      case "Level":
        return _getLevelCellWidget(dataGridCell);
      case "Last Played":
        return _getLastPlayedCellWidget(dataGridCell);
      case "Loadout":
        return _getLoadoutCellWidget(dataGridCell);
    }

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Text(dataGridCell.value.toString()),
      ),
    );
  }
}
