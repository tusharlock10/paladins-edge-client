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

class _MatchDetailPlayerLoadout extends StatelessWidget {
  final models.Champion champion;
  final models.MatchPlayer matchPlayer;
  const _MatchDetailPlayerLoadout({
    required this.champion,
    required this.matchPlayer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: matchPlayer.playerChampionCards.map(
        (playerChampionCard) {
          final card = champion.cards.firstOrNullWhere(
            (_) => _.cardId2 == playerChampionCard.cardId2,
          );

          if (card == null) {
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
                height: 32 / constants.ImageAspectRatios.championCard,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}

class MatchDetailPlayerCard extends HookConsumerWidget {
  final models.MatchPlayer matchPlayer;
  final double averageCredits;

  const MatchDetailPlayerCard({
    required this.matchPlayer,
    required this.averageCredits,
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
    final kdaFormatted = matchPlayer.playerStats.kdaFormatted;
    final isPrivatePlayer = matchPlayer.playerId == "0";
    final partyNumber = matchPlayer.partyNumber;
    final isBot = matchPlayer.playerStats.creditsEarned < averageCredits * 0.5;
    final partyColor =
        partyNumber != null ? constants.partyColors[partyNumber - 1] : null;

    // Hooks
    final playerPosition = useMemoized(
      () {
        final matchPosition = matchPlayer.matchPosition;
        if (matchPosition == null) return null;

        switch (matchPosition) {
          case 1:
            return "MVP";
          case 2:
            return "2nd";
          case 3:
            return "3rd";
          default:
            return "${matchPosition}th";
        }
      },
      [matchPlayer.matchPosition],
    );

    final playerPositionIcon = useMemoized(
      () {
        final matchPosition = matchPlayer.matchPosition;
        if (matchPosition == null) return null;

        if (matchPosition == 1) return FeatherIcons.award;
        if (matchPosition == 10) return FeatherIcons.meh;
      },
      [matchPlayer.matchPosition],
    );

    final playerPositionColor = useMemoized(
      () {
        final matchPosition = matchPlayer.matchPosition;

        switch (matchPosition) {
          case 1:
            return Colors.orange;
          case 10:
            return Colors.blueGrey;
          default:
            return Colors.cyan;
        }
      },
      [matchPlayer.matchPosition],
    );
    final playerHighestStat = useMemoized(
      () {
        final totalDamageDealt = matchPlayer.playerStats.totalDamageDealt;
        final totalDamageTaken = matchPlayer.playerStats.totalDamageTaken;
        final healingDone = matchPlayer.playerStats.healingDone;
        final damageShielded = matchPlayer.playerStats.damageShielded;
        final maxStat = [
          totalDamageDealt,
          totalDamageTaken,
          healingDone,
          damageShielded,
        ].max()!;

        if (maxStat == damageShielded) return "Shielded $maxStat";
        if (maxStat == totalDamageTaken) return "Tanked $maxStat";
        if (maxStat == healingDone) return "Healed $maxStat";

        return "Damage $maxStat";
      },
      [matchPlayer],
    );

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
      [matchPlayer],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
      child: Row(
        children: [
          champion == null
              ? const SizedBox(height: 50, width: 50)
              : Stack(
                  clipBehavior: Clip.none,
                  children: [
                    widgets.FastImage(
                      imageUrl: utilities.getSmallAsset(champion.iconUrl),
                      imageBlurHash: champion.iconBlurHash,
                      height: 50,
                      width: 50,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.5)),
                      greyedOut: isBot,
                    ),
                    if (isBot)
                      const Positioned.fill(
                        bottom: -34,
                        right: -34,
                        child: Icon(
                          FeatherIcons.link,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                  ],
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 160,
                child: widgets.InteractiveText(
                  isPrivatePlayer ? "Private Profile" : matchPlayer.playerName,
                  onTap: isPrivatePlayer ? null : onPressPlayer,
                  style: TextStyle(
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
                  if (playerPosition != null)
                    widgets.TextChip(
                      width: 55,
                      text: playerPosition,
                      icon: playerPositionIcon,
                      color: playerPositionColor,
                    ),
                ],
              ),
            ],
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
                        text: "($kdaFormatted)",
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(playerHighestStat),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
