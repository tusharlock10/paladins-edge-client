import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/champion_detail/stat_label.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:timer_builder/timer_builder.dart';

class PlayerStats extends ConsumerWidget {
  const PlayerStats({Key? key}) : super(key: key);

  Map<String, dynamic> getStatLabelGridProps(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    final size = MediaQuery.of(context).size;
    const itemHeight = 60.0;
    int crossAxisCount;

    crossAxisCount = size.height < size.width ? 4 : 2;
    final itemWidth = constraints.maxWidth / crossAxisCount;

    return {
      'itemHeight': itemHeight,
      'itemWidth': itemWidth,
      'crossAxisCount': crossAxisCount,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;
    final playerChampions = ref.read(providers.champions).playerChampions;
    final playerChampion =
        utilities.findPlayerChampion(playerChampions, champion.championId);

    if (playerChampion == null) {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'You have not played enough matches on this champion',
          textAlign: TextAlign.center,
        ),
      );
    }

    final playTimeString =
        '${(playerChampion.playTime ~/ 60)}hrs ${playerChampion.playTime % 60}min';

    String kdr = ((playerChampion.totalKills + playerChampion.totalAssists) /
            playerChampion.totalDeaths)
        .toStringAsPrecision(2);

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final props = getStatLabelGridProps(context, constraints);

            final double itemHeight = props['itemHeight'] as double;
            final double itemWidth = props['itemWidth'] as double;
            final int crossAxisCount = props['crossAxisCount'] as int;

            return ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: SizedBox(
                height: itemHeight * 8 / crossAxisCount,
                width: constraints.maxWidth,
                child: GridView.count(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: (itemWidth - 5) / (itemHeight - 5),
                  padding: EdgeInsets.zero,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    StatLabel(
                      label: 'Wins',
                      text: NumberFormat.compact()
                          .format(playerChampion.wins)
                          .toString(),
                    ),
                    StatLabel(
                      label: 'Looses',
                      text: NumberFormat.compact()
                          .format(playerChampion.losses)
                          .toString(),
                    ),
                    StatLabel(
                      label: 'Kills',
                      text: NumberFormat.compact()
                          .format(playerChampion.totalKills)
                          .toString(),
                    ),
                    StatLabel(
                      label: 'Deaths',
                      text: NumberFormat.compact()
                          .format(playerChampion.totalDeaths)
                          .toString(),
                    ),
                    StatLabel(
                      label: 'Play Time',
                      text: playTimeString,
                    ),
                    TimerBuilder.periodic(
                      const Duration(minutes: 1),
                      builder: (_) {
                        return StatLabel(
                          label: 'Last Played',
                          text: utilities
                              .getLastPlayedTime(playerChampion.lastPlayed),
                        );
                      },
                    ),
                    StatLabel(
                      label: 'KD Ratio',
                      text: kdr,
                    ),
                    StatLabel(
                      label: 'Credits',
                      text:
                          '${(playerChampion.totalCredits ~/ playerChampion.playTime).toString()} Per Min',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
