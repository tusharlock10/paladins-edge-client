import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:jiffy/jiffy.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/data_classes/match/index.dart";
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class _RecentMatchesBar extends HookConsumerWidget {
  final String playerId;

  const _RecentMatchesBar({
    required this.playerId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playerNotifier = providers.players(playerId);
    final combinedMatches = ref.watch(
      playerNotifier.select((_) => _.combinedMatches),
    );
    final playerInferred = ref.watch(
      playerNotifier.select((_) => _.playerInferred),
    );

    // Hooks
    final filteredCombinedMatches = useMemoized(
      () {
        if (combinedMatches == null) {
          return List<CombinedMatch>.empty();
        }

        return combinedMatches.where((_) => !_.hide);
      },
      [combinedMatches],
    );

    final winStats = useMemoized(
      () {
        int normalMatches = 0;
        int normalWins = 0;
        int rankedMatches = 0;
        int rankedWins = 0;

        if (filteredCombinedMatches.isEmpty) {
          return const data_classes.RecentWinStats();
        }

        for (final combinedMatch in filteredCombinedMatches) {
          if (utilities.isTrainingMatch(combinedMatch.match)) continue;

          final matchPlayer = utilities.getMatchPlayerFromPlayerId(
            combinedMatch.matchPlayers,
            playerInferred?.playerId,
          );
          if (matchPlayer == null) continue;

          final isWin = matchPlayer.team == combinedMatch.match.winningTeam;
          if (combinedMatch.match.isRankedMatch) {
            rankedMatches++;
            rankedWins += isWin ? 1 : 0;
          } else {
            normalMatches++;
            normalWins += isWin ? 1 : 0;
          }
        }

        return data_classes.RecentWinStats(
          normalMatches: normalMatches,
          normalWins: normalWins,
          rankedMatches: rankedMatches,
          rankedWins: rankedWins,
        );
      },
      [filteredCombinedMatches],
    );

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final normalMatches = winStats.normalMatches;
    final normalWins = winStats.normalWins;
    final rankedMatches = winStats.rankedMatches;
    final rankedWins = winStats.rankedWins;
    final totalWins = normalWins + rankedWins;
    final totalMatches = normalMatches + rankedMatches;
    final winRate = totalMatches != 0 ? totalWins / totalMatches : 0;
    final winRateFormatted = (winRate * 100).toStringAsPrecision(3);
    final winRateColor = utilities.getWinRateColor(winRate);
    final isLowWinRate = winRate < 0.4;
    final isFilterApplied =
        combinedMatches?.length != filteredCombinedMatches.length;
    final filterAppliedText = isFilterApplied ? "(filters applied)" : "";

    // Hooks
    final matchesText = useMemoized(
      () {
        if (totalMatches == 0) return null;
        if (totalMatches == rankedMatches) return "ranked matches";
        if (totalMatches == normalMatches) return "casual matches";

        return "matches";
      },
      [normalMatches, rankedMatches],
    );

    if (matchesText == null) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "RECENT WIN RATE",
          style: textTheme.bodyLarge?.copyWith(
            fontSize: 14,
            color: textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "Last $totalMatches $matchesText $filterAppliedText",
          style: textTheme.bodyLarge?.copyWith(
            fontSize: 10,
            color: textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 28,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                  gradient: LinearGradient(colors: [
                    winRateColor.withOpacity(0.35),
                    Colors.white.withOpacity(0.35),
                  ]),
                ),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [winRateColor.shade300, winRateColor],
                        ),
                      ),
                      width: constraints.maxWidth * winRate,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 10),
                      child: isLowWinRate
                          ? null
                          : Text(
                              "$winRateFormatted%",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                    if (isLowWinRate)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "$winRateFormatted%",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isLightTheme
                                  ? winRateColor
                                  : winRateColor.shade100,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RecentPartyMemberCard extends HookWidget {
  static const itemHeight = 60.0;
  static const itemWidth = 200.0;
  final models.BasicPlayer player;
  const _RecentPartyMemberCard({
    required this.player,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textTheme = Theme.of(context).textTheme;

    // Methods
    final onTap = useCallback(
      () {
        utilities.Navigation.push(
          context,
          screens.PlayerDetail.routeName,
          params: {
            "playerId": player.playerId,
          },
        );
      },
      [player],
    );

    return SizedBox(
      width: itemWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(isLightTheme ? 0.75 : 0.25),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: 10,
            right: 10,
          ),
          child: Row(
            children: [
              widgets.ElevatedAvatar(
                imageUrl: player.avatarUrl,
                imageBlurHash: player.avatarBlurHash,
                size: 18,
                borderRadius: 8,
                elevation: 3,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widgets.InteractiveText(
                      player.name,
                      onTap: onTap,
                      style: textTheme.displayLarge!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    if (player.title != null)
                      Text(
                        player.title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyLarge?.copyWith(fontSize: 9.5),
                      ),
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

class _RecentlyPlayedChampionCard extends HookWidget {
  static const itemHeight = 90.0;
  static const itemWidth = 190.0;
  final models.Champion champion;
  final models.PlayerChampion? playerChampion;

  const _RecentlyPlayedChampionCard({
    required this.champion,
    required this.playerChampion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textTheme = Theme.of(context).textTheme;
    final winRate = playerChampion?.winRate;
    final winRateFormatted = playerChampion?.winRateFormatted;
    final lastPlayed = playerChampion?.lastPlayed;
    final kda = playerChampion?.kda;
    final kdaFormatted = playerChampion?.kdaFormatted;
    final kdaColor = kda == null ? null : utilities.getKDAColor(kda);
    final winRateColor =
        winRate == null ? null : utilities.getWinRateColor(winRate);

    // Hooks
    final lastPlayedFormatted = useMemoized(
      () {
        if (lastPlayed == null) return null;

        final duration = DateTime.now().difference(lastPlayed);
        if (duration > const Duration(days: 1)) {
          return "Last played ${Jiffy.parseFromDateTime(lastPlayed).yMMMd}";
        }

        return "Played ${Jiffy.parseFromDateTime(lastPlayed).fromNow()}";
      },
      [lastPlayed],
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

    return SizedBox(
      width: itemWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(isLightTheme ? 0.75 : 0.25),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5,
            bottom: 5,
            left: 10,
            right: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Row(
                children: [
                  widgets.ElevatedAvatar(
                    imageUrl: championIcon.optimizedUrl,
                    imageBlurHash: championIcon.blurHash,
                    isAssetImage: championIcon.isAssetImage,
                    size: 18,
                    borderRadius: 8,
                    elevation: 3,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          champion.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.displayLarge?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          champion.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyLarge?.copyWith(fontSize: 9.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (playerChampion != null) const SizedBox(height: 2),
              if (playerChampion != null)
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "WR ",
                        style: textTheme.bodyLarge?.copyWith(fontSize: 11),
                        children: [
                          TextSpan(
                            text: "$winRateFormatted %",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: winRateColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    RichText(
                      text: TextSpan(
                        text: "LVL ",
                        style: textTheme.bodyLarge?.copyWith(fontSize: 11),
                        children: [
                          TextSpan(
                            text: playerChampion!.level.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    RichText(
                      text: TextSpan(
                        text: "KDA ",
                        style: textTheme.bodyLarge?.copyWith(fontSize: 11),
                        children: [
                          TextSpan(
                            text: kdaFormatted,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kdaColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              if (playerChampion != null) const SizedBox(height: 2),
              if (lastPlayedFormatted != null)
                Text(
                  lastPlayedFormatted,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyLarge?.copyWith(fontSize: 10),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayerInfo extends StatelessWidget {
  final models.Player player;
  const _PlayerInfo({
    required this.player,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final playerSince =
        Jiffy.parseFromDateTime(player.accountCreationDate).yMMMd;
    final humanizedTime = utilities.getFormattedPlayTime(player.hoursPlayed);

    return SizedBox(
      height: widgets.PlayerStatsCard.itemHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: utilities.insertBetween(
          [
            widgets.PlayerStatsCard(
              title: "Total Matches",
              stat: player.totalLosses + player.totalWins,
            ),
            widgets.PlayerStatsCard(
              title: "Level",
              stat: player.level,
            ),
            widgets.PlayerStatsCard(
              title: "Play Time",
              stat: 0,
              statString: humanizedTime,
            ),
            widgets.PlayerStatsCard(
              title: "Player Since",
              stat: 0,
              statString: playerSince,
            ),
            widgets.PlayerStatsCard(
              title: "Region",
              stat: 0,
              statString: player.region,
            ),
            widgets.PlayerStatsCard(
              title: "Platform",
              stat: 0,
              statString: player.platform,
            ),
          ],
          const SizedBox(width: 10),
        ),
      ),
    );
  }
}

class _RecentPlayerStats extends StatelessWidget {
  final models.MatchPlayerStats playerStats;
  const _RecentPlayerStats({
    required this.playerStats,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final kda = playerStats.kda;
    final kdaFormatted = playerStats.kdaFormatted;
    final kdaColor = utilities.getKDAColor(kda);

    return SizedBox(
      height: widgets.PlayerStatsCard.itemHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: utilities.insertBetween(
          [
            widgets.PlayerStatsCard(
              title: "KDA",
              stat: 0,
              statString: kdaFormatted,
              color: kdaColor,
            ),
            widgets.PlayerStatsCard(
              title: "Kills",
              stat: playerStats.kills,
            ),
            widgets.PlayerStatsCard(
              title: "Deaths",
              stat: playerStats.deaths,
            ),
            widgets.PlayerStatsCard(
              title: "Damage",
              stat: playerStats.totalDamageDealt,
            ),
            widgets.PlayerStatsCard(
              title: "Healing",
              stat: playerStats.healingDone,
            ),
            widgets.PlayerStatsCard(
              title: "Dmg Taken",
              stat: playerStats.totalDamageTaken,
            ),
            widgets.PlayerStatsCard(
              title: "Credits",
              stat: playerStats.creditsEarned,
            ),
            widgets.PlayerStatsCard(
              title: "Shielding",
              stat: playerStats.damageShielded,
            ),
          ],
          const SizedBox(width: 10),
        ),
      ),
    );
  }
}

class PlayerDetailHeaderExpandablePanel extends HookConsumerWidget {
  final String playerId;

  const PlayerDetailHeaderExpandablePanel({
    required this.playerId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playerNotifier = providers.players(playerId);
    final player = ref.watch(
      playerNotifier.select((_) => _.playerData),
    );
    final playerInferred = ref.watch(
      playerNotifier.select((_) => _.playerInferred),
    );
    final champions = ref.watch(
      providers.champions.select((_) => _.champions),
    );
    final playerChampions = ref.watch(
      providers.champions.select((_) => _.playerChampions),
    );

    if (playerInferred == null || player == null) return const SizedBox();

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final recentPartyMembers = playerInferred.recentPartyMembers;
    final recentlyPlayedChampionIds = playerInferred.recentlyPlayedChampions;

    // Hooks
    final recentlyPlayedChampions = useMemoized(
      () {
        final List<models.Champion?> recentlyPlayedChampions = [];

        for (final championId in recentlyPlayedChampionIds) {
          final champion = champions.firstOrNullWhere(
            (_) => _.championId == championId,
          );
          recentlyPlayedChampions.add(champion);
        }

        return recentlyPlayedChampions;
      },
      [recentlyPlayedChampionIds],
    );
    final recentlyPlayedPlayerChampions = useMemoized(
      () {
        final List<models.PlayerChampion?> recentlyPlayedPlayerChampions = [];

        for (final championId in recentlyPlayedChampionIds) {
          final playerChampion = playerChampions?.firstOrNullWhere(
            (_) => _.championId == championId,
          );
          recentlyPlayedPlayerChampions.add(playerChampion);
        }

        return recentlyPlayedPlayerChampions;
      },
      [recentlyPlayedChampionIds],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        _RecentMatchesBar(playerId: playerId),
        const SizedBox(height: 20),
        Text(
          "MORE PLAYER INFO",
          style: textTheme.bodyLarge?.copyWith(
            fontSize: 14,
            color: textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        _PlayerInfo(player: player),
        const SizedBox(height: 20),
        if (recentPartyMembers.isNotEmpty) ...[
          Text(
            "RECENTLY PLAYED WITH",
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 14,
              color: textTheme.bodyLarge?.color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: _RecentPartyMemberCard.itemHeight,
            child: ListView.separated(
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              scrollDirection: Axis.horizontal,
              itemCount: recentPartyMembers.length,
              itemBuilder: (_, index) {
                final recentPartyMember = recentPartyMembers.elementAt(index);

                return _RecentPartyMemberCard(player: recentPartyMember);
              },
            ),
          ),
        ],
        const SizedBox(height: 20),
        if (recentlyPlayedChampions.isNotEmpty) ...[
          Text(
            "RECENTLY PLAYED CHAMPION${recentlyPlayedChampions.length != 1 ? 'S' : ''}",
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 14,
              color: textTheme.bodyLarge?.color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: _RecentlyPlayedChampionCard.itemHeight,
            child: ListView.separated(
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              scrollDirection: Axis.horizontal,
              itemCount: recentlyPlayedChampions.length,
              itemBuilder: (_, index) {
                final recentlyPlayedChampion =
                    recentlyPlayedChampions.elementAtOrNull(
                  index,
                );
                final recentlyPlayedPlayerChampion =
                    recentlyPlayedPlayerChampions.elementAtOrNull(
                  index,
                );

                if (recentlyPlayedChampion == null) return const SizedBox();

                return _RecentlyPlayedChampionCard(
                  champion: recentlyPlayedChampion,
                  playerChampion: recentlyPlayedPlayerChampion,
                );
              },
            ),
          ),
        ],
        const SizedBox(height: 20),
        Text(
          "AVERAGE STATS PER MATCH",
          style: textTheme.bodyLarge?.copyWith(
            fontSize: 14,
            color: textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        _RecentPlayerStats(playerStats: playerInferred.averageStats),
      ],
    );
  }
}
