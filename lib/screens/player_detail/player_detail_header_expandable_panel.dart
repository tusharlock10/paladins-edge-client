import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:intl/intl.dart";
import "package:jiffy/jiffy.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class _RecentMatchesBar extends HookConsumerWidget {
  const _RecentMatchesBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final combinedMatches = ref.watch(
      providers.matches.select((_) => _.combinedMatches),
    );
    final playerInferred = ref.watch(
      providers.players.select((_) => _.playerInferred),
    );

    // Hooks
    final winStats = useMemoized(
      () {
        int normalMatches = 0;
        int normalWins = 0;
        int rankedMatches = 0;
        int rankedWins = 0;

        if (combinedMatches != null) {
          for (final combinedMatch in combinedMatches) {
            if (combinedMatch.match.queue.contains("Training")) continue;
            final matchPlayer = combinedMatch.matchPlayers.firstOrNullWhere(
              (_) => _.playerId == playerInferred?.playerId,
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
        }

        return data_classes.RecentWinStats(
          normalMatches: normalMatches,
          normalWins: normalWins,
          rankedMatches: rankedMatches,
          rankedWins: rankedWins,
        );
      },
      [combinedMatches],
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
    final winRate = normalMatches != 0 ? totalWins / totalMatches : 0;
    final winRateFormatted = (winRate * 100).toStringAsPrecision(3);
    final winRateColor = utilities.getWinRateColor(winRate);
    final isLowWinRate = winRate < 0.4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "RECENT WIN RATE",
          style: textTheme.bodyText1?.copyWith(
            fontSize: 14,
            color: textTheme.bodyText1?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "Last ${rankedMatches + normalMatches} matches",
          style: textTheme.bodyText1?.copyWith(
            fontSize: 10,
            color: textTheme.bodyText1?.color,
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
        utilities.Navigation.navigate(
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
                      style: textTheme.headline1!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    if (player.title != null)
                      Text(
                        player.title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyText1?.copyWith(fontSize: 9.5),
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
          return "Last played ${Jiffy(lastPlayed).yMMMd}";
        }

        return "Played ${Jiffy(lastPlayed).fromNow()}";
      },
      [lastPlayed],
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
                    imageUrl: champion.iconUrl,
                    imageBlurHash: champion.iconBlurHash,
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
                          style: textTheme.headline1?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          champion.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyText1?.copyWith(fontSize: 9.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (playerChampion != null) const SizedBox(height: 5),
              if (playerChampion != null)
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "WR ",
                        style: textTheme.bodyText1?.copyWith(fontSize: 11),
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
                        style: textTheme.bodyText1?.copyWith(fontSize: 11),
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
                        style: textTheme.bodyText1?.copyWith(fontSize: 11),
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
              if (playerChampion != null) const SizedBox(height: 5),
              if (lastPlayedFormatted != null)
                Text(
                  lastPlayedFormatted,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyText1?.copyWith(fontSize: 10),
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
    final playerSince = Jiffy(player.accountCreationDate).yMMMd;
    final humanizedTime = utilities.getFormattedPlayTime(player.hoursPlayed);

    return SizedBox(
      height: _PlayerStatsCard.itemHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: utilities.insertBetween(
          [
            _PlayerStatsCard(
              title: "Total Matches",
              stat: player.totalLosses + player.totalWins,
            ),
            _PlayerStatsCard(
              title: "Level",
              stat: player.level,
            ),
            _PlayerStatsCard(
              title: "Play Time",
              stat: 0,
              statString: humanizedTime,
            ),
            _PlayerStatsCard(
              title: "Player Since",
              stat: 0,
              statString: playerSince,
            ),
            _PlayerStatsCard(
              title: "Region",
              stat: 0,
              statString: player.region,
            ),
            _PlayerStatsCard(
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
      height: _PlayerStatsCard.itemHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: utilities.insertBetween(
          [
            _PlayerStatsCard(
              title: "KDA",
              stat: 0,
              statString: kdaFormatted,
              color: kdaColor,
            ),
            _PlayerStatsCard(
              title: "Kills",
              stat: playerStats.kills,
            ),
            _PlayerStatsCard(
              title: "Deaths",
              stat: playerStats.deaths,
            ),
            _PlayerStatsCard(
              title: "Damage",
              stat: playerStats.totalDamageDealt,
            ),
            _PlayerStatsCard(
              title: "Healing",
              stat: playerStats.healingDone,
            ),
            _PlayerStatsCard(
              title: "Dmg Taken",
              stat: playerStats.totalDamageTaken,
            ),
            _PlayerStatsCard(
              title: "Credits",
              stat: playerStats.creditsEarned,
            ),
            _PlayerStatsCard(
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

class _PlayerStatsCard extends StatelessWidget {
  static const itemHeight = 56.0;
  static const itemWidth = 120.0;
  final String title;
  final num stat;
  final String? statString;
  final Color? color;
  const _PlayerStatsCard({
    required this.title,
    required this.stat,
    this.statString,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textTheme = Theme.of(context).textTheme;
    final String? formattedStat;
    formattedStat = statString ??
        (stat < 8000
            ? stat.toStringAsPrecision(stat.toInt().toString().length + 1)
            : NumberFormat.compact().format(stat));

    return SizedBox(
      width: itemWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(isLightTheme ? 0.75 : 0.25),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.bodyText2,
            ),
            const SizedBox(height: 3),
            Text(
              formattedStat,
              textAlign: TextAlign.center,
              style: textTheme.bodyText1?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerDetailHeaderExpandablePanel extends HookConsumerWidget {
  const PlayerDetailHeaderExpandablePanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final player = ref.watch(
      providers.players.select((_) => _.playerData),
    );
    final playerInferred = ref.watch(
      providers.players.select((_) => _.playerInferred),
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
        return champions.where(
          (champion) => recentlyPlayedChampionIds.contains(champion.championId),
        );
      },
      [recentlyPlayedChampionIds],
    );
    final recentlyPlayedPlayerChampions = useMemoized(
      () {
        return recentlyPlayedChampionIds.map(
          (championId) => playerChampions?.firstWhere(
            (_) => _.championId == championId,
          ),
        );
      },
      [recentlyPlayedChampionIds],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const _RecentMatchesBar(),
        const SizedBox(height: 20),
        Text(
          "MORE PLAYER INFO",
          style: textTheme.bodyText1?.copyWith(
            fontSize: 14,
            color: textTheme.bodyText1?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        _PlayerInfo(player: player),
        const SizedBox(height: 20),
        Text(
          "RECENTLY PLAYED WITH",
          style: textTheme.bodyText1?.copyWith(
            fontSize: 14,
            color: textTheme.bodyText1?.color,
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
        const SizedBox(height: 20),
        Text(
          "RECENTLY PLAYED CHAMPION${recentlyPlayedChampions.length != 1 ? 'S' : ''}",
          style: textTheme.bodyText1?.copyWith(
            fontSize: 14,
            color: textTheme.bodyText1?.color,
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
              final recentlyPlayedChampion = recentlyPlayedChampions.elementAt(
                index,
              );
              final recentlyPlayedPlayerChampion =
                  recentlyPlayedPlayerChampions.elementAt(
                index,
              );

              return _RecentlyPlayedChampionCard(
                champion: recentlyPlayedChampion,
                playerChampion: recentlyPlayedPlayerChampion,
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "AVERAGE STATS PER MATCH",
          style: textTheme.bodyText1?.copyWith(
            fontSize: 14,
            color: textTheme.bodyText1?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        _RecentPlayerStats(playerStats: playerInferred.averageStats),
      ],
    );
  }
}
