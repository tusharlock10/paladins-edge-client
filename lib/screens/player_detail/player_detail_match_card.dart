import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:intl/intl.dart";
import "package:jiffy/jiffy.dart";
import "package:paladinsedge/constants.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;
import "package:timer_builder/timer_builder.dart";

class PlayerDetailMatchCard extends HookConsumerWidget {
  final models.MatchPlayer? matchPlayer;
  final models.Champion? champion;
  final models.Match match;

  static const itemExtent = _itemHeight + _itemMargin * 2;
  static const _itemMargin = 7.0;
  static const _itemHeight = 130.0;

  const PlayerDetailMatchCard({
    required this.matchPlayer,
    required this.champion,
    required this.match,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchPlayer = this.matchPlayer;
    final champion = this.champion;
    if (matchPlayer == null || champion == null) {
      return _PlayerDetailUnknownMatchCard(match: match);
    }

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final playerStats = matchPlayer.playerStats;
    final talentUsed = champion.talents
        .firstOrNullWhere((_) => _.talentId2 == matchPlayer.talentId2);
    final loadout = matchPlayer.playerChampionCards.map(
      (playerChampionCard) {
        // find the card from that champion
        final card = champion.cards
            .firstOrNullWhere((_) => _.cardId2 == playerChampionCard.cardId2);

        return data_classes.LoadoutItem(
          card: card,
          cardLevel: playerChampionCard.cardLevel,
        );
      },
    );

    // Methods
    final onTap = useCallback(
      () {
        utilities.Navigation.navigate(
          context,
          screens.MatchDetail.routeName,
          params: {
            "matchId": match.matchId,
            "playerId": matchPlayer.playerId,
          },
        );
      },
      [match, matchPlayer],
    );

    return widgets.InteractiveCard(
      onTap: onTap,
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: _itemMargin),
      borderRadius: 10,
      child: Row(
        children: [
          Container(
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
                    imageUrl: utilities.getSmallAsset(champion.iconUrl),
                    imageBlurHash: champion.iconBlurHash,
                    size: 28,
                    borderRadius: 28,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${playerStats.kills} / ${playerStats.deaths} / ${playerStats.assists}",
                        style: textTheme.bodyText1?.copyWith(fontSize: 18),
                      ),
                      Text(
                        match.map
                            .replaceFirst("LIVE ", "")
                            .replaceFirst("WIP ", ""),
                        style: textTheme.bodyText1?.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  talentUsed == null
                      ? const SizedBox(height: 48, width: 48)
                      : widgets.FastImage(
                          imageUrl:
                              utilities.getSmallAsset(talentUsed.imageUrl),
                          height: 48,
                          width: 48,
                        ),
                  ...loadout.map(
                    (loadoutItem) {
                      final cardImageUrl = loadoutItem.card?.imageUrl;
                      if (cardImageUrl == null) return const SizedBox();

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: widgets.FastImage(
                          imageUrl: utilities.getSmallAsset(cardImageUrl),
                          imageBlurHash: loadoutItem.card?.imageBlurHash,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          height: 24,
                          width: 24 * constants.ImageAspectRatios.championCard,
                        ),
                      );
                    },
                  ).toList(),
                ],
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    match.queue,
                    style: textTheme.headline2?.copyWith(fontSize: 14),
                  ),
                  TimerBuilder.periodic(
                    const Duration(minutes: 1),
                    builder: (_) {
                      return Text(
                        Jiffy(match.matchStartTime).fromNow(),
                        style: textTheme.bodyText1?.copyWith(fontSize: 12),
                      );
                    },
                  ),
                  matchPlayer.playerStats.biggestKillStreak > 5
                      ? widgets.TextChip(
                          icon: FeatherIcons.zap,
                          color: Colors.orange,
                          text:
                              "${matchPlayer.playerStats.biggestKillStreak} streak",
                        )
                      : const SizedBox(),
                  matchPlayer.playerStats.totalDamageDealt >
                          matchPlayer.playerStats.healingDone
                      ? Text(
                          "${NumberFormat.compact().format(matchPlayer.playerStats.totalDamageDealt)} Dmg",
                          style: textTheme.bodyText1?.copyWith(
                            fontSize: 12,
                            color: Colors.red.shade400,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      : Text(
                          "${NumberFormat.compact().format(matchPlayer.playerStats.healingDone)} Heal",
                          style: textTheme.bodyText1?.copyWith(
                            fontSize: 12,
                            color: Colors.green.shade400,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerDetailUnknownMatchCard extends StatelessWidget {
  final models.Match match;
  static const _itemMargin = 7.0;

  const _PlayerDetailUnknownMatchCard({
    required this.match,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return widgets.InteractiveCard(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: _itemMargin),
      borderRadius: 10,
      child: Row(
        children: [
          Container(
            width: 10,
            color: Colors.yellow,
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Something is wrong with this match"),
                  const SizedBox(height: 10),
                  Text("MatchID : ${match.matchId}"),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
