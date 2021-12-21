import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:timer_builder/timer_builder.dart';

class _LoadoutItem {
  final models.Card? card;
  final int cardLevel;

  _LoadoutItem({
    required this.card,
    required this.cardLevel,
  });
}

class _PlayerMatchCard extends ConsumerWidget {
  final models.MatchPlayer matchPlayer;
  final models.Champion champion;
  final models.Match match;

  const _PlayerMatchCard({
    required this.matchPlayer,
    required this.champion,
    required this.match,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final playerStats = matchPlayer.playerStats;

    final talentUsed = champion.talents
        ?.firstWhere((_) => _.talentId2 == matchPlayer.talentId2);
    final loadout = matchPlayer.playerChampionCards.map((playerChampionCard) {
      // find the card from that champion
      final card = champion.cards
          ?.firstWhere((_) => _.cardId2 == playerChampionCard.cardId2);
      return _LoadoutItem(card: card, cardLevel: playerChampionCard.cardLevel);
    });

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 10,
              color: match.winningTeam == matchPlayer.team
                  ? Colors.green
                  : Colors.red,
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    widgets.ElevatedAvatar(
                      imageUrl: champion.iconUrl,
                      size: 28,
                      borderRadius: 28,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${playerStats.kills} / ${playerStats.deaths} / ${playerStats.assists}',
                          style: textTheme.bodyText1?.copyWith(fontSize: 18),
                        ),
                        Text(
                          match.map.replaceFirst('LIVE ', ''),
                          style: textTheme.bodyText1?.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    talentUsed != null
                        ? widgets.FastImage(
                            imageUrl: talentUsed.imageUrl,
                            height: 48,
                            width: 48,
                          )
                        : const SizedBox(),
                    ...loadout.map(
                      (loadoutItem) {
                        final cardImageUrl = loadoutItem.card?.imageUrl;
                        if (cardImageUrl == null) return const SizedBox();
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: widgets.FastImage(
                            imageUrl: cardImageUrl,
                            borderRadius: BorderRadius.circular(5),
                            height: 24,
                            width:
                                24 * constants.ImageAspectRatios.championCard,
                          ),
                        );
                      },
                    ).toList()
                  ],
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          match.queue,
                          style: textTheme.headline2?.copyWith(fontSize: 14),
                        ),
                        const SizedBox(width: 10),
                        TimerBuilder.periodic(
                          const Duration(minutes: 1),
                          builder: (_) {
                            return Text(
                              Jiffy(match.matchStartTime).fromNow(),
                              style:
                                  textTheme.bodyText1?.copyWith(fontSize: 12),
                            );
                          },
                        ),
                      ],
                    ),
                    matchPlayer.playerStats.biggestKillStreak > 5
                        ? Text(
                            '${matchPlayer.playerStats.biggestKillStreak} streak',
                            style: textTheme.bodyText1?.copyWith(fontSize: 14),
                          )
                        : const SizedBox(),
                    matchPlayer.playerStats.totalDamageDealt >
                            matchPlayer.playerStats.healingDone
                        ? Text(
                            '${NumberFormat.compact().format(matchPlayer.playerStats.totalDamageDealt)} Dmg',
                            style: textTheme.bodyText1?.copyWith(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            '${NumberFormat.compact().format(matchPlayer.playerStats.healingDone)} Heal',
                            style: textTheme.bodyText1?.copyWith(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlayerMatches extends ConsumerWidget {
  const PlayerMatches({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerMatches =
        ref.watch(providers.matches.select((_) => _.playerMatches));
    final champions = ref.read(providers.champions).champions;

    if (playerMatches == null) {
      return const widgets.LoadingIndicator(size: 36);
    }

    return Expanded(
      child: ListView.builder(
        itemCount: playerMatches.matchPlayers.length,
        itemBuilder: (context, index) {
          final matchPlayer = playerMatches.matchPlayers[index];

          // find the match that is associated with that matchPlayer
          final match = playerMatches.matches
              .firstWhere((_) => _.matchId == matchPlayer.matchId);

          // champion that this player played in the match
          final champion = champions.firstWhere(
              (_) => _.championId == matchPlayer.championId.toString());

          return _PlayerMatchCard(
            matchPlayer: matchPlayer,
            champion: champion,
            match: match,
          );
        },
      ),
    );
  }
}