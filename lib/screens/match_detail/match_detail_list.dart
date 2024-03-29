import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/match_detail/match_detail_player_card.dart";
import "package:paladinsedge/screens/match_detail/match_detail_stats.dart";
import "package:paladinsedge/screens/match_detail/match_detail_team_header.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class MatchDetailList extends HookConsumerWidget {
  final String matchId;
  final data_classes.CombinedMatch? combinedMatch;
  final bool isSavedMatch;
  const MatchDetailList({
    required this.matchId,
    required this.combinedMatch,
    required this.isSavedMatch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers ̰
    final matchNotifier = providers.matches(matchId);
    final matchProvider = !isSavedMatch ? ref.read(matchNotifier) : null;
    final isMatchDetailsLoading = !isSavedMatch
        ? ref.watch(matchNotifier.select((_) => _.isMatchDetailsLoading))
        : false;
    final champions = ref.watch(providers.champions.select((_) => _.champions));

    // Variables
    final matchPlayers = combinedMatch?.matchPlayers;
    final match = combinedMatch?.match;
    final championBans = match?.championBans.toList();
    final isLandscape = utilities.responsiveCondition(
      context,
      desktop: true,
      tablet: true,
      mobile: false,
    );
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = utilities.responsiveCondition(
      context,
      desktop: screenWidth * 0.125,
      tablet: 15.0,
      mobile: 15.0,
    );

    // Effects
    useEffect(
      () {
        if (matchProvider == null) return null;
        // call matchDetail api
        matchProvider.getMatchDetails();

        return matchProvider.resetMatchDetails;
      },
      [],
    );

    // Hooks
    final winningTeamMatchPlayers = useMemoized(
      () {
        return matchPlayers
                ?.where((_) => _.team == match?.winningTeam)
                .toList() ??
            [];
      },
      [matchPlayers, match],
    );

    final losingTeamMatchPlayers = useMemoized(
      () {
        return matchPlayers
                ?.where((_) => _.team != match?.winningTeam)
                .toList() ??
            [];
      },
      [matchPlayers, match],
    );

    final winningTeamStats = useMemoized(
      () {
        final teamStats = data_classes.MatchTeamStats(
          kills: 0,
          deaths: 0,
          assists: 0,
        );
        if (winningTeamMatchPlayers.isEmpty) return null;

        for (final matchPlayer in winningTeamMatchPlayers) {
          teamStats.kills += matchPlayer.playerStats.kills.toInt();
          teamStats.deaths += matchPlayer.playerStats.deaths.toInt();
          teamStats.assists += matchPlayer.playerStats.assists.toInt();
        }

        return teamStats;
      },
      [winningTeamMatchPlayers],
    );

    final losingTeamStats = useMemoized(
      () {
        final teamStats = data_classes.MatchTeamStats(
          kills: 0,
          deaths: 0,
          assists: 0,
        );
        if (losingTeamMatchPlayers.isEmpty) return null;

        for (final matchPlayer in losingTeamMatchPlayers) {
          teamStats.kills += matchPlayer.playerStats.kills.toInt();
          teamStats.deaths += matchPlayer.playerStats.deaths.toInt();
          teamStats.assists += matchPlayer.playerStats.assists.toInt();
        }

        return teamStats;
      },
      [losingTeamMatchPlayers],
    );

    final winningTeamBans = useMemoized(
      () {
        List<models.Champion> winningTeamBans = [];
        if (match == null || championBans == null) return winningTeamBans;

        final isFirstTeam = match.winningTeam == 1;
        final middleIndex = championBans.length ~/ 2;
        List<int> banIds = championBans.sublist(middleIndex);
        if (isFirstTeam) {
          banIds = championBans.sublist(0, middleIndex);
        }

        winningTeamBans = banIds.mapIndexedNotNull((index, championId) {
          return champions.firstOrNullWhere((_) => _.championId == championId);
        }).toList();

        return winningTeamBans;
      },
      [match, championBans],
    );

    final losingTeamBans = useMemoized(
      () {
        List<models.Champion> losingTeamBans = [];
        if (match == null || championBans == null) return losingTeamBans;

        final isFirstTeam = match.winningTeam == 2;
        final middleIndex = championBans.length ~/ 2;
        List<int> banIds = championBans.sublist(middleIndex);
        if (isFirstTeam) {
          banIds = championBans.sublist(0, middleIndex);
        }
        losingTeamBans = banIds.mapIndexedNotNull((index, championId) {
          return champions.firstOrNullWhere((_) => _.championId == championId);
        }).toList();

        return losingTeamBans;
      },
      [match, championBans],
    );

    if (isMatchDetailsLoading) {
      return SliverList(
        delegate: SliverChildListDelegate.fixed(
          [
            SizedBox(
              height: utilities.getBodyHeight(context),
              child: const Center(
                child: widgets.LoadingIndicator(
                  lineWidth: 2,
                  size: 28,
                  label: Text("Getting match"),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (combinedMatch == null) {
      return SliverList(
        delegate: SliverChildListDelegate.fixed(
          [
            SizedBox(
              height: utilities.getBodyHeight(context),
              child: const Center(
                child: Text("Unable to fetch details for this match"),
              ),
            ),
          ],
        ),
      );
    }

    // Widgets
    final winningTeamColumn = match == null
        ? const SizedBox()
        : Column(
            children: [
              if (winningTeamStats != null)
                MatchDetailTeamHeader(
                  teamStats: winningTeamStats,
                  isWinningTeam: true,
                  bannedChampions: winningTeamBans,
                ),
              for (int playerIndex = 0;
                  playerIndex < winningTeamMatchPlayers.length;
                  playerIndex++)
                MatchDetailPlayerCard(
                  matchPlayer: winningTeamMatchPlayers[playerIndex],
                  match: match,
                ),
            ],
          );

    final losingTeamColumn = match == null
        ? const SizedBox()
        : Column(
            children: [
              if (losingTeamStats != null)
                MatchDetailTeamHeader(
                  teamStats: losingTeamStats,
                  isWinningTeam: false,
                  bannedChampions: losingTeamBans,
                ),
              for (int playerIndex = 0;
                  playerIndex < losingTeamMatchPlayers.length;
                  playerIndex++)
                MatchDetailPlayerCard(
                  matchPlayer: losingTeamMatchPlayers[playerIndex],
                  match: match,
                ),
            ],
          );

    return SliverToBoxAdapter(
      child: isLandscape
          ? Column(
              children: [
                MatchDetailStats(combinedMatch: combinedMatch),
                const Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      Expanded(child: winningTeamColumn),
                      const SizedBox(width: 10),
                      Expanded(child: losingTeamColumn),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            )
          : Column(
              children: [
                MatchDetailStats(combinedMatch: combinedMatch),
                const Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    children: [
                      winningTeamColumn,
                      const SizedBox(height: 20),
                      if (losingTeamStats != null) const Divider(),
                      losingTeamColumn,
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
