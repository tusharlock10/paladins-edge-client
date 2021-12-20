import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
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

  String? getHighestMultiKill(models.MatchPlayerStats playerStats) {
    String? multiKill;
    if (playerStats.pentaKills != 0) multiKill = "Penta Kill";
    if (playerStats.quadraKills != 0) multiKill = "Quadra Kill";
    if (playerStats.tripleKills != 0) multiKill = "Triple Kill";
    if (playerStats.doubleKills != 0) multiKill = "Double Kill";

    return multiKill;
  }

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
    final multiKill = getHighestMultiKill(playerStats);

    return Card(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  widgets.ElevatedAvatar(
                    imageUrl: champion.iconUrl,
                    size: 28,
                    borderRadius: 28,
                  ),
                  Text(
                    '${playerStats.kills} / ${playerStats.deaths} / ${playerStats.assists}',
                    style: textTheme.bodyText1?.copyWith(fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: [
                  talentUsed != null
                      ? Image.network(
                          talentUsed.imageUrl,
                          height: 48,
                          width: 48,
                        )
                      : const SizedBox(),
                  ...loadout.map(
                    (loadoutItem) {
                      final cardImageUrl = loadoutItem.card?.imageUrl;
                      if (cardImageUrl == null) return const SizedBox();
                      return Stack(
                        children: [
                          Image.network(
                            cardImageUrl,
                            height: 36,
                            width: 36,
                          ),
                          Text(loadoutItem.cardLevel.toString()),
                        ],
                      );
                    },
                  ).toList()
                ],
              )
            ],
          ),
          Column(
            children: [
              Text(match.queue),
              TimerBuilder.periodic(
                const Duration(minutes: 1),
                builder: (_) {
                  return Text(Jiffy(match.matchStartTime).fromNow());
                },
              ),
              multiKill != null ? Text(multiKill) : const SizedBox()
            ],
          )
        ],
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
