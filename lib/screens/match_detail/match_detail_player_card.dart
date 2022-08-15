import "package:cached_network_image/cached_network_image.dart";
import "package:dartx/dartx.dart";
import "package:duration/duration.dart";
import "package:expandable/expandable.dart";
import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:intl/intl.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class _PlayerStatsCard extends StatelessWidget {
  static const itemHeight = 46.0;
  static const itemWidth = 110.0;
  final String title;
  final num stat;
  final String? statString;
  const _PlayerStatsCard({
    required this.title,
    required this.stat,
    this.statString,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textTheme = Theme.of(context).textTheme;
    final String? formattedStat;
    formattedStat = statString ?? NumberFormat.decimalPattern().format(stat);

    return SizedBox(
      width: itemWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(isLightTheme ? 0.6 : 0.20),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: textTheme.bodyText2?.copyWith(fontSize: 12),
            ),
            const SizedBox(height: 2),
            Text(
              formattedStat,
              textAlign: TextAlign.center,
              style: textTheme.bodyText1?.copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
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
    final items = ref.watch(providers.items.select((_) => _.items));

    // Variables
    final brightness = Theme.of(context).brightness;
    final textTheme = Theme.of(context).textTheme;
    final expandedController = ExpandableController(initialExpanded: false);
    final kills = matchPlayer.playerStats.kills;
    final deaths = matchPlayer.playerStats.deaths;
    final assists = matchPlayer.playerStats.assists;
    final kdaFormatted = matchPlayer.playerStats.kdaFormatted;
    final isPrivatePlayer = matchPlayer.playerId == "0";
    final partyNumber = matchPlayer.partyNumber;
    final isBot =
        matchPlayer.playerStats.creditsEarned < averageCredits * 0.6 ||
            matchPlayer.talentId2 == 0;
    final backgroundColor = Theme.of(context).cardTheme.color;
    final showBackgroundSplash = utilities.RemoteConfig.showBackgroundSplash;
    final partyColor =
        partyNumber != null ? constants.partyColors[partyNumber - 1] : null;

    // Hooks
    final champion = useMemoized(
      () {
        return champions.firstOrNullWhere(
          (champion) => champion.championId == matchPlayer.championId,
        );
      },
      [matchPlayer, champions],
    );
    final playerItemsUsed = useMemoized(
      () {
        final List<data_classes.MatchPlayerItemUsed> playerItemsUsed = [];
        if (items == null) return playerItemsUsed;

        for (final playerItem in matchPlayer.playerItems) {
          final item = items
              .firstOrNullWhere((item) => item.itemId == playerItem.itemId);
          if (item != null) {
            playerItemsUsed.add(
              data_classes.MatchPlayerItemUsed(
                playerItem: playerItem,
                item: item,
              ),
            );
          }
        }

        return playerItemsUsed;
      },
      [matchPlayer, items],
    );
    final talentUsed = useMemoized(
      () {
        return champion?.talents.firstOrNullWhere(
          (_) => _.talentId2 == matchPlayer.talentId2,
        );
      },
      [champion, matchPlayer],
    );
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

    final splashBackground = useMemoized(
      () {
        if (!showBackgroundSplash) return null;
        if (champion == null) return null;

        var splashBackground = data_classes.PlatformOptimizedImage(
          imageUrl: champion.splashUrl,
          isAssetImage: false,
        );
        if (!constants.isWeb) {
          final assetUrl = utilities.getAssetImageUrl(
            constants.ChampionAssetType.splash,
            champion.championId,
          );
          if (assetUrl != null) {
            splashBackground.imageUrl = assetUrl;
            splashBackground.isAssetImage = true;
          }
        }

        return splashBackground;
      },
      [champion, showBackgroundSplash],
    );

    final championIcon = useMemoized(
      () {
        if (champion == null) return null;

        var championIcon = data_classes.PlatformOptimizedImage(
          imageUrl: utilities.getSmallAsset(champion.iconUrl),
          isAssetImage: false,
          blurHash: champion.iconBlurHash,
        );
        if (!constants.isWeb) {
          final assetUrl = utilities.getAssetImageUrl(
            constants.ChampionAssetType.icons,
            champion.championId,
          );
          if (assetUrl != null) {
            championIcon.imageUrl = assetUrl;
            championIcon.isAssetImage = true;
          }
        }

        return championIcon;
      },
      [champion],
    );

    final matchPlayerHighestStat = utilities.matchPlayerHighestStat(
      matchPlayer.playerStats,
      champion?.role,
    );
    final highestStatText =
        "${matchPlayerHighestStat.type} ${utilities.humanizeNumber(matchPlayerHighestStat.stat)}";

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

    final onTalentPress = useCallback(
      () {
        if (champion != null) {
          if (talentUsed != null) {
            widgets.showTalentDetailSheet(
              context,
              talentUsed,
              champion,
            );
          }
        }
      },
      [talentUsed, champion],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            image: champion != null && splashBackground != null
                ? DecorationImage(
                    image: (splashBackground.isAssetImage
                        ? AssetImage(splashBackground.imageUrl)
                        : CachedNetworkImageProvider(
                            splashBackground.imageUrl,
                          )) as ImageProvider,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    colorFilter: ColorFilter.mode(
                      Color.fromRGBO(
                        255,
                        255,
                        255,
                        brightness == Brightness.light ? 0.145 : 0.225,
                      ),
                      BlendMode.modulate,
                    ),
                  )
                : null,
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7.5, vertical: 7.5),
                child: Row(
                  children: [
                    championIcon == null
                        ? const SizedBox(height: 50, width: 50)
                        : Stack(
                            clipBehavior: Clip.none,
                            children: [
                              widgets.ElevatedAvatar(
                                imageUrl: championIcon.imageUrl,
                                imageBlurHash: championIcon.blurHash,
                                isAssetImage: championIcon.isAssetImage,
                                size: 30,
                                borderRadius: 12.5,
                                greyedOut: isBot,
                                margin: const EdgeInsets.all(2.5),
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
                        ? const SizedBox(width: 5)
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
                                  utilities.shortRankName(
                                    matchPlayer.playerRanked!.rankName,
                                  ),
                                  style: textTheme.bodyText1?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: widgets.InteractiveText(
                                  isPrivatePlayer
                                      ? "Private Profile"
                                      : matchPlayer.playerName,
                                  onTap: isPrivatePlayer ? null : onPressPlayer,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isPrivatePlayer
                                        ? FontWeight.normal
                                        : FontWeight.bold,
                                    fontStyle: isPrivatePlayer
                                        ? FontStyle.italic
                                        : FontStyle.normal,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                highestStatText,
                                style: textTheme.bodyText1?.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  if (talentUsed != null) ...[
                                    GestureDetector(
                                      onTap: onTalentPress,
                                      child: widgets.FastImage(
                                        height: 34,
                                        width: 34,
                                        imageUrl: utilities
                                            .getSmallAsset(talentUsed.imageUrl),
                                        semanticText: talentUsed.name,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                  ],
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Credits",
                                        style: textTheme.bodyText1?.copyWith(
                                          fontSize: 9,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      Text(
                                        matchPlayer.playerStats.creditsEarned
                                            .toString(),
                                        style: textTheme.bodyText1
                                            ?.copyWith(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 3),
                                  if (playerPosition != null)
                                    widgets.TextChip(
                                      width: 55,
                                      text: playerPosition,
                                      icon: playerPositionIcon,
                                      color: playerPositionColor,
                                    ),
                                ],
                              ),
                              RichText(
                                text: TextSpan(
                                  style: textTheme.bodyText1?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: matchPlayer.partyNumber != null
                                          ? "party ${matchPlayer.partyNumber}"
                                          : "solo",
                                      style: TextStyle(
                                        color: partyColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "  $kills / $deaths / $assists  ",
                                    ),
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
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    ValueListenableBuilder<bool>(
                      valueListenable: expandedController,
                      builder: (context, isExpanded, _) {
                        return AnimatedRotation(
                          duration: const Duration(
                            milliseconds: 200,
                          ),
                          turns: isExpanded ? 0.5 : 0,
                          child: widgets.IconButton(
                            iconSize: 22,
                            onPressed: expandedController.toggle,
                            icon: Icons.keyboard_arrow_down,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              ExpandablePanel(
                controller: expandedController,
                collapsed: const SizedBox(),
                expanded: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: utilities.insertBetween(
                          [
                            ...playerItemsUsed.map(
                              (playerItemUsed) => widgets.FastImage(
                                width: 32,
                                height:
                                    32 / constants.ImageAspectRatios.itemIcon,
                                imageUrl: playerItemUsed.item.imageUrl,
                                imageBlurHash:
                                    playerItemUsed.item.imageBlurHash,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            if (champion != null)
                              widgets.MatchPlayerLoadout(
                                matchPlayer: matchPlayer,
                                champion: champion,
                                size: 38,
                              ),
                          ],
                          const SizedBox(width: 5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: _PlayerStatsCard.itemHeight,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: utilities.insertBetween(
                          [
                            const SizedBox(),
                            if (matchPlayer.playerStats.totalDamageDealt != 0)
                              _PlayerStatsCard(
                                title: "Damage",
                                stat: matchPlayer.playerStats.totalDamageDealt,
                              ),
                            if (matchPlayer.playerStats.healingDone != 0)
                              _PlayerStatsCard(
                                title: "Healing",
                                stat: matchPlayer.playerStats.healingDone,
                              ),
                            if (matchPlayer.playerStats.damageShielded != 0)
                              _PlayerStatsCard(
                                title: "Shielding",
                                stat: matchPlayer.playerStats.damageShielded,
                              ),
                            if (matchPlayer.playerStats.totalDamageTaken != 0)
                              _PlayerStatsCard(
                                title: "Damage Taken",
                                stat: matchPlayer.playerStats.totalDamageTaken,
                              ),
                            if (matchPlayer.playerStats.selfHealingDone != 0)
                              _PlayerStatsCard(
                                title: "Self Heal",
                                stat: matchPlayer.playerStats.selfHealingDone,
                              ),
                            if (matchPlayer.playerStats.objectiveTime != 0)
                              _PlayerStatsCard(
                                title: "Objective Time",
                                stat: matchPlayer.playerStats.objectiveTime,
                                statString: printDuration(
                                  Duration(
                                    seconds: matchPlayer
                                        .playerStats.objectiveTime
                                        .toInt(),
                                  ),
                                  abbreviated: true,
                                  upperTersity: DurationTersity.second,
                                  tersity: DurationTersity.second,
                                  conjugation: " ",
                                ),
                              ),
                            const SizedBox(),
                          ],
                          const SizedBox(width: 10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
