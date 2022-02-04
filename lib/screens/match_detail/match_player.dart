import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/constants.dart' as constsnts;
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class MatchPlayer extends ConsumerWidget {
  final models.MatchPlayer matchPlayer;

  const MatchPlayer({
    required this.matchPlayer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final champions = ref.watch(providers.champions.select((_) => _.champions));

    final champion = champions.firstWhere(
      (champion) => champion.championId == matchPlayer.championId.toString(),
    );

    final talentUsed = champion.talents
        .firstWhere((_) => _.talentId2 == matchPlayer.talentId2);

    final kills = matchPlayer.playerStats.kills;
    final deaths = matchPlayer.playerStats.deaths;
    final assists = matchPlayer.playerStats.assists;
    final kda = deaths == 0
        ? "Perfect"
        : ((kills + assists) / deaths).toStringAsFixed(2);

    final isPrivatePlayer = matchPlayer.playerId == "0";

    String matchPosition = ' ${matchPlayer.matchPosition}th ';

    if (matchPlayer.matchPosition == 1) matchPosition = "MVP";
    if (matchPlayer.matchPosition == 2) matchPosition = " 2nd ";
    if (matchPlayer.matchPosition == 3) matchPosition = " 3rd ";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: Row(
        children: [
          widgets.FastImage(
            imageUrl: champion.iconUrl,
            height: 50,
            width: 50,
            borderRadius: const BorderRadius.all(Radius.circular(12.5)),
          ),
          matchPlayer.playerRanked == null
              ? const SizedBox(width: 20)
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      widgets.FastImage(
                        imageUrl: matchPlayer.playerRanked!.rankIconUrl,
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        utilities
                            .shortRankName(matchPlayer.playerRanked!.rankName),
                        style: textTheme.bodyText1?.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isPrivatePlayer ? 'Private Profile' : matchPlayer.playerName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight:
                      isPrivatePlayer ? FontWeight.normal : FontWeight.bold,
                  fontStyle:
                      isPrivatePlayer ? FontStyle.italic : FontStyle.normal,
                ),
              ),
              Row(
                children: [
                  widgets.FastImage(
                    imageUrl: talentUsed.imageUrl,
                    height: 32,
                    width: 32,
                  ),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Credits',
                        style: textTheme.bodyText1?.copyWith(
                          fontSize: 9,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        matchPlayer.playerStats.creditsEarned.toString(),
                        style: textTheme.bodyText1?.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(width: 5),
                  widgets.TextChip(
                    text: matchPosition,
                    color: matchPosition == "MVP" ? Colors.orange : Colors.cyan,
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$kills / $deaths / $assists  ($kda)',
                  style: textTheme.bodyText1?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: matchPlayer.playerChampionCards.map(
                    (playerChampionCard) {
                      final card = champion.cards.firstWhere(
                        (_) => _.cardId2 == playerChampionCard.cardId2,
                      );

                      return GestureDetector(
                        onTap: () => widgets.showLoadoutCardDetailSheet(
                          data_classes.ShowLoadoutDetailsOptions(
                            context: context,
                            champion: champion,
                            card: card,
                            cardPoints: playerChampionCard.cardLevel,
                            sliderFixed: true,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: widgets.FastImage(
                            imageUrl: card.imageUrl,
                            width: 32,
                            height:
                                32 / constsnts.ImageAspectRatios.championCard,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}