import "package:cached_network_image/cached_network_image.dart";
import "package:dartx/dartx.dart";
import "package:expandable/expandable.dart";
import "package:flutter/material.dart";
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
              style: textTheme.bodyMedium?.copyWith(fontSize: 12),
            ),
            const SizedBox(height: 2),
            Text(
              formattedStat,
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class ActiveMatchPlayer extends HookConsumerWidget {
  final models.ActiveMatchPlayersInfo playerInfo;

  const ActiveMatchPlayer({
    required this.playerInfo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final champions = ref.read(providers.champions).champions;
    final baseRanks = ref.read(providers.baseRanks).baseRanks;
    final playerChampions = ref.watch(
      providers.champions.select((_) => _.playerChampions),
    );
    final showChampionSplashImage = ref.watch(
      providers.appState.select((_) => _.settings.showChampionSplashImage),
    );

    // Variables
    final expandedController = ExpandableController(initialExpanded: false);
    final textTheme = Theme.of(context).textTheme;
    final isPrivatePlayer = playerInfo.player.playerId == "0";
    final winRate = playerInfo.ranked?.winRate;
    final winRateFormatted = playerInfo.ranked?.winRateFormatted;
    final brightness = Theme.of(context).brightness;
    final backgroundColor = Theme.of(context).cardTheme.color;

    // Hooks
    final champion = useMemoized(
      () {
        return champions.firstOrNullWhere(
          (champion) => champion.championId == playerInfo.championId,
        );
      },
      [champions, playerInfo],
    );

    final playerChampion = useMemoized(
      () {
        if (playerChampions == null) return null;

        return playerChampions.firstOrNullWhere(
          (_) => _.playerId == playerInfo.player.playerId,
        );
      },
      [playerChampions, playerInfo],
    );

    final championPlaytime = useMemoized(
      () {
        if (playerChampion == null) return null;

        final duration = Duration(minutes: playerChampion.playTime);
        if (duration.inHours == 0) return "${duration.inMinutes}min";

        return "${duration.inHours}h ${duration.inMinutes % 60}m";
      },
      [playerChampion],
    );

    final championCPM = useMemoized(
      () {
        if (playerChampion == null) return null;

        final totalMatches = playerChampion.wins + playerChampion.losses;
        final totalCredits = playerChampion.totalCredits;
        final cpm = totalCredits / totalMatches;

        return "${cpm.round()} CR";
      },
      [playerChampion],
    );

    final championLastPlayed = useMemoized(
      () {
        if (playerChampion == null) return null;

        return utilities.getLastPlayedTime(
          playerChampion.lastPlayed,
          shortFormat: true,
        );
      },
      [playerChampion],
    );

    final championIcon = useMemoized(
      () {
        if (champion == null) return null;

        return data_classes.PlatformOptimizedImage(
          imageUrl: champion.iconUrl,
          blurHash: champion.iconBlurHash,
          assetId: champion.championId,
          assetType: constants.ChampionAssetType.icons,
        );
      },
      [champion],
    );

    final splashBackground = useMemoized(
      () {
        if (!showChampionSplashImage) return null;
        if (champion == null) return null;

        return data_classes.PlatformOptimizedImage(
          imageUrl: champion.splashUrl,
          assetType: constants.ChampionAssetType.splash,
          assetId: champion.championId,
          blurHash: champion.splashBlurHash,
        );
      },
      [champion, showChampionSplashImage],
    );

    final playerInfoBaseRank = useMemoized(
      () => baseRanks[playerInfo.ranked?.rank],
      [playerInfo, baseRanks],
    );

    final rankIcon = useMemoized(
      () {
        if (playerInfoBaseRank == null) return null;

        return data_classes.PlatformOptimizedImage(
          imageUrl: playerInfoBaseRank.rankIconUrl,
          assetType: constants.ChampionAssetType.ranks,
          assetId: playerInfoBaseRank.rank,
        );
      },
      [playerInfoBaseRank],
    );

    // Methods
    final onTapPlayer = useCallback(
      () {
        if (isPrivatePlayer) return;

        utilities.Navigation.navigate(
          context,
          screens.PlayerDetail.routeName,
          params: {
            "playerId": playerInfo.player.playerId,
          },
        );
      },
      [],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          image: champion != null && splashBackground != null
              ? DecorationImage(
                  image: (splashBackground.isAssetImage
                      ? AssetImage(splashBackground.optimizedUrl)
                      : CachedNetworkImageProvider(
                          splashBackground.optimizedUrl,
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
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          onTap: () => playerChampion == null
              ? widgets.showToast(
                  context: context,
                  text: "Stats not available for this player",
                  type: widgets.ToastType.info,
                )
              : expandedController.toggle(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    championIcon == null
                        ? const SizedBox(height: 24 * 2, width: 24 * 2)
                        : widgets.ElevatedAvatar(
                            imageUrl: championIcon.optimizedUrl,
                            imageBlurHash: championIcon.blurHash,
                            isAssetImage: championIcon.isAssetImage,
                            borderRadius: 12.5,
                            size: 30,
                          ),
                    playerInfoBaseRank == null
                        ? const SizedBox(width: 20)
                        : Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                if (rankIcon != null)
                                  widgets.FastImage(
                                    isAssetImage: rankIcon.isAssetImage,
                                    imageUrl: rankIcon.optimizedUrl,
                                    height: 22,
                                    width: 22,
                                  ),
                                const SizedBox(height: 5),
                                Text(
                                  utilities.shortRankName(
                                    playerInfoBaseRank.rankName,
                                  ),
                                  style: textTheme.bodyLarge?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: onTapPlayer,
                          child: Text(
                            isPrivatePlayer
                                ? "Private Profile"
                                : playerInfo.player.playerName,
                            style: TextStyle(
                              decoration: isPrivatePlayer
                                  ? TextDecoration.none
                                  : TextDecoration.underline,
                              fontSize: 16,
                              fontWeight: isPrivatePlayer
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                              fontStyle: isPrivatePlayer
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                            ),
                          ),
                        ),
                        Text(
                          "Level ${playerInfo.player.level}",
                          style: textTheme.bodyLarge?.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (winRate != null && winRateFormatted != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: [
                                        const TextSpan(text: "WR "),
                                        TextSpan(
                                          text: "$winRateFormatted%",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: utilities
                                                .getWinRateColor(winRate),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "${playerInfo.ranked!.wins}W ${playerInfo.ranked!.looses}L",
                                    style: textTheme.bodyLarge
                                        ?.copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            const SizedBox(width: 10),
                            ValueListenableBuilder<bool>(
                              valueListenable: expandedController,
                              builder: (context, isExpanded, _) {
                                if (playerChampion == null) {
                                  return const SizedBox();
                                }

                                return Row(
                                  children: [
                                    if (champion != null)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Stats",
                                            style: textTheme.bodyLarge
                                                ?.copyWith(fontSize: 10),
                                          ),
                                          Text(
                                            champion.name,
                                            style: textTheme.bodyLarge
                                                ?.copyWith(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    AnimatedRotation(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      turns: isExpanded ? 0.5 : 0,
                                      child: const Icon(
                                        Icons.keyboard_arrow_down,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ExpandablePanel(
                controller: expandedController,
                collapsed: const SizedBox(),
                expanded: playerChampion != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 10),
                        child: SizedBox(
                          height: _PlayerStatsCard.itemHeight,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: utilities.insertBetween(
                              [
                                const SizedBox(),
                                _PlayerStatsCard(
                                  title: "Play Time",
                                  stat: 0,
                                  statString: championPlaytime,
                                ),
                                _PlayerStatsCard(
                                  title: "Level",
                                  stat: playerChampion.level,
                                ),
                                _PlayerStatsCard(
                                  title: "Matches",
                                  stat: playerChampion.matches,
                                ),
                                _PlayerStatsCard(
                                  title: "Champ. WR",
                                  stat: 0,
                                  statString:
                                      "${playerChampion.winRateFormatted}%",
                                ),
                                if (championCPM != null)
                                  _PlayerStatsCard(
                                    title: "Credits/Match",
                                    stat: 0,
                                    statString: championCPM,
                                  ),
                                _PlayerStatsCard(
                                  title: "KDA",
                                  stat: 0,
                                  statString: playerChampion.kdaFormatted,
                                ),
                                _PlayerStatsCard(
                                  title: "Last Played",
                                  stat: 0,
                                  statString: championLastPlayed,
                                ),
                                const SizedBox(),
                              ],
                              const SizedBox(width: 10),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
