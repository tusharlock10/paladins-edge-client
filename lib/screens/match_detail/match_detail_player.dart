import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class MatchDetailPlayer extends HookConsumerWidget {
  final models.MatchPlayer matchPlayer;

  const MatchDetailPlayer({
    required this.matchPlayer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final champions = ref.watch(providers.champions.select((_) => _.champions));

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final champion = champions.firstOrNullWhere(
      (champion) => champion.championId == matchPlayer.championId,
    );
    final talentUsed = champion?.talents
        .firstOrNullWhere((_) => _.talentId2 == matchPlayer.talentId2);
    final kills = matchPlayer.playerStats.kills;
    final deaths = matchPlayer.playerStats.deaths;
    final assists = matchPlayer.playerStats.assists;
    final kda = deaths == 0
        ? "Perfect"
        : ((kills + assists) / deaths).toStringAsFixed(2);
    final isPrivatePlayer = matchPlayer.playerId == "0";
    final partyNumber = matchPlayer.partyNumber;
    final partyColor =
        partyNumber != null ? constants.partyColors[partyNumber - 1] : null;
    String matchPosition = " ${matchPlayer.matchPosition}th ";

    if (matchPlayer.matchPosition == 1) matchPosition = "MVP";
    if (matchPlayer.matchPosition == 2) matchPosition = " 2nd ";
    if (matchPlayer.matchPosition == 3) matchPosition = " 3rd ";

    // Methods
    final onPressPlayer = useCallback(
      () {
        if (isPrivatePlayer) return null;

        utilities.Navigation.navigate(
          context,
          screens.PlayerDetail.routeName,
          params: {
            "playerId": matchPlayer.playerId,
          },
        );
      },
      [],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
      child: Row(
        children: [
          champion == null
              ? const SizedBox(height: 50, width: 50)
              : widgets.FastImage(
                  imageUrl: utilities.getSmallAsset(champion.iconUrl),
                  imageBlurHash: champion.iconBlurHash,
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
                        imageUrl: utilities.getSmallAsset(
                          matchPlayer.playerRanked!.rankIconUrl,
                        ),
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
          GestureDetector(
            onTap: onPressPlayer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 160,
                  child: Text(
                    isPrivatePlayer
                        ? "Private Profile"
                        : matchPlayer.playerName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      decoration: isPrivatePlayer
                          ? TextDecoration.none
                          : TextDecoration.underline,
                      fontSize: 14,
                      fontWeight:
                          isPrivatePlayer ? FontWeight.normal : FontWeight.bold,
                      fontStyle:
                          isPrivatePlayer ? FontStyle.italic : FontStyle.normal,
                    ),
                  ),
                ),
                Row(
                  children: [
                    talentUsed == null
                        ? const SizedBox(height: 32, width: 32)
                        : widgets.FastImage(
                            imageUrl:
                                utilities.getSmallAsset(talentUsed.imageUrl),
                            height: 32,
                            width: 32,
                          ),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Credits",
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
                      width: 55,
                      text: matchPosition,
                      icon: matchPlayer.matchPosition == 1
                          ? FeatherIcons.award
                          : matchPlayer.matchPosition == 10
                              ? FeatherIcons.meh
                              : null,
                      color: matchPlayer.matchPosition == 1
                          ? Colors.orange
                          : matchPlayer.matchPosition == 10
                              ? Colors.blueGrey
                              : Colors.cyan,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    style: textTheme.bodyText1?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      if (matchPlayer.partyNumber != null)
                        TextSpan(
                          text: "party ${matchPlayer.partyNumber}",
                          style: TextStyle(
                            color: partyColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        )
                      else
                        const TextSpan(
                          text: "solo",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      TextSpan(text: "  $kills / $deaths / $assists  "),
                      TextSpan(
                        text: "($kda)",
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: matchPlayer.playerChampionCards.map(
                    (playerChampionCard) {
                      final card = champion?.cards.firstOrNullWhere(
                        (_) => _.cardId2 == playerChampionCard.cardId2,
                      );

                      if (card == null || champion == null) {
                        return const SizedBox();
                      }

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
                            imageUrl: utilities.getSmallAsset(card.imageUrl),
                            imageBlurHash: card.imageBlurHash,
                            width: 32,
                            height:
                                32 / constants.ImageAspectRatios.championCard,
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
