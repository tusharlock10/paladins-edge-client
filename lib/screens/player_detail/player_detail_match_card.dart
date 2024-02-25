import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:jiffy/jiffy.dart";
import "package:paladinsedge/constants/index.dart" as constants;
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
  final bool isSavedMatch;
  final bool isCommonMatch;

  static const itemExtent = _itemHeight + _itemMargin * 2;
  static const _itemMargin = 7.0;
  static const _itemHeight = 130.0;

  const PlayerDetailMatchCard({
    required this.matchPlayer,
    required this.champion,
    required this.match,
    this.isSavedMatch = false,
    this.isCommonMatch = false,
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
    final talentUsed = champion.talents.firstOrNullWhere(
      (_) => _.talentId2 == matchPlayer.talentId2,
    );
    final isMVP = matchPlayer.matchPosition == 1;
    final matchPlayerHighestStat = utilities.matchPlayerHighestStat(
      matchPlayer.playerStats,
      champion.role,
      true,
    );
    final highestStatText =
        "${matchPlayerHighestStat.type} ${utilities.humanizeNumber(matchPlayerHighestStat.stat)}";

    // Hooks
    final splashBackground = useMemoized(
      () {
        return data_classes.PlatformOptimizedImage(
          imageUrl: champion.splashUrl,
          assetType: constants.ChampionAssetType.splash,
          assetId: champion.championId,
        );
      },
      [champion],
    );

    final championIcon = useMemoized(
      () {
        return data_classes.PlatformOptimizedImage(
          imageUrl: utilities.getSmallAsset(champion.iconUrl),
          blurHash: champion.iconBlurHash,
          assetType: constants.ChampionAssetType.icons,
          assetId: champion.championId,
        );
      },
      [champion],
    );

    // Methods
    final onTap = useCallback(
      () {
        String routeName = screens.MatchDetail.routeName;
        if (isSavedMatch) routeName = screens.MatchDetail.savedMatchRouteName;
        if (isCommonMatch) routeName = screens.MatchDetail.commonMatchRouteName;

        utilities.Navigation.navigate(
          context,
          routeName,
          params: {
            "matchId": match.matchId,
            if (!isSavedMatch) "playerId": matchPlayer.playerId,
          },
          queryParams: {
            if (isSavedMatch) "isSavedMatch": "true",
          },
        );
      },
      [match, matchPlayer, isSavedMatch, isCommonMatch],
    );

    final onTalentPress = useCallback(
      () {
        if (talentUsed != null) {
          widgets.showTalentDetailSheet(
            context,
            talentUsed,
            champion,
          );
        }
      },
      [talentUsed, champion],
    );

    return widgets.InteractiveCard(
      onTap: onTap,
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: _itemMargin),
      borderRadius: 10,
      backgroundImage: splashBackground.optimizedUrl,
      isAssetImage: splashBackground.isAssetImage,
      child: Row(
        children: [
          Container(
            width: 10,
            color: match.winningTeam == matchPlayer.team
                ? Colors.green
                : Colors.red,
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    widgets.ElevatedAvatar(
                      imageUrl: championIcon.optimizedUrl,
                      imageBlurHash: championIcon.blurHash,
                      isAssetImage: championIcon.isAssetImage,
                      size: 28,
                      borderRadius: 28,
                      borderSide: isMVP
                          ? const BorderSide(
                              color: Colors.orange,
                              width: 2.5,
                            )
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: textTheme.bodyLarge
                                  ?.copyWith(fontSize: isMVP ? 16 : 18),
                              children: [
                                if (isMVP)
                                  const TextSpan(
                                    text: "MVP  ",
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                TextSpan(
                                  text:
                                      "${playerStats.kills} / ${playerStats.deaths} / ${playerStats.assists}",
                                ),
                              ],
                            ),
                          ),
                          Text(
                            match.map
                                .replaceFirst("LIVE ", "")
                                .replaceFirst("WIP ", ""),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyLarge?.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    talentUsed == null
                        ? const SizedBox(height: 48, width: 48)
                        : GestureDetector(
                            onTap: onTalentPress,
                            child: widgets.FastImage(
                              imageUrl:
                                  utilities.getSmallAsset(talentUsed.imageUrl),
                              height: 48,
                              width: 48,
                            ),
                          ),
                    widgets.MatchPlayerLoadout(
                      champion: champion,
                      matchPlayer: matchPlayer,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    match.queue,
                    textAlign: TextAlign.center,
                    style: textTheme.displayMedium?.copyWith(fontSize: 14),
                  ),
                  TimerBuilder.periodic(
                    const Duration(minutes: 1),
                    builder: (_) {
                      return Text(
                        Jiffy.parseFromDateTime(match.matchStartTime).fromNow(),
                        style: textTheme.bodyLarge?.copyWith(fontSize: 13),
                      );
                    },
                  ),
                  matchPlayer.playerStats.biggestKillStreak > 7
                      ? widgets.TextChip(
                          icon: FeatherIcons.zap,
                          color: Colors.orange,
                          text:
                              "${matchPlayer.playerStats.biggestKillStreak} streak",
                        )
                      : const SizedBox(),
                  widgets.TextChip(
                    text: highestStatText,
                    color: matchPlayerHighestStat.color,
                    icon: matchPlayerHighestStat.icon,
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
                  SelectableText("MatchID : ${match.matchId}"),
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
