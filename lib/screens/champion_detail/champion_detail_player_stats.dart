import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/champion_detail/champion_detail_stat_label.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:timer_builder/timer_builder.dart';

class ChampionDetailPlayerStats extends HookConsumerWidget {
  const ChampionDetailPlayerStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final userPlayerChampions =
        ref.read(providers.champions).userPlayerChampions;
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));

    final champion = context.currentBeamLocation.data as models.Champion;
    final playerChampion =
        utilities.findPlayerChampion(userPlayerChampions, champion.championId);

    if (isGuest) {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Stats not available for Guest Users',
          textAlign: TextAlign.center,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      );
    }

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

    String kda = ((playerChampion.totalKills + playerChampion.totalAssists) /
            playerChampion.totalDeaths)
        .toStringAsPrecision(2);

    // Methods
    final getStatLabelGridProps = useCallback(
      (
        BuildContext context,
        BoxConstraints constraints,
      ) {
        final size = MediaQuery.of(context).size;
        final props = data_classes.StatLabelGridProps(
          crossAxisCount: size.height < size.width ? 4 : 2,
          itemHeight: 60,
          itemWidth: 0,
        );

        props.itemWidth = constraints.maxWidth / props.crossAxisCount;

        return props;
      },
      [],
    );

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

            return ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: SizedBox(
                height: props.itemHeight * 8 / props.crossAxisCount,
                width: constraints.maxWidth,
                child: GridView.count(
                  crossAxisCount: props.crossAxisCount,
                  childAspectRatio:
                      (props.itemWidth - 5) / (props.itemHeight - 5),
                  padding: EdgeInsets.zero,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    StatLabel(
                      label: 'W / L',
                      text:
                          '${NumberFormat.compact().format(playerChampion.wins).toString()} / ${NumberFormat.compact().format(playerChampion.losses).toString()}',
                    ),
                    StatLabel(
                      label: 'Level',
                      text: NumberFormat.compact()
                          .format(playerChampion.level)
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
                      label: 'KDA',
                      text: kda,
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
