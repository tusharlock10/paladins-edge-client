import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/match_detail/match_detail_team_header.dart';
import 'package:paladinsedge/screens/match_detail/match_player.dart';
import 'package:paladinsedge/screens/match_detail/match_stats.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class MatchDetailList extends HookConsumerWidget {
  const MatchDetailList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchesProvider = ref.read(providers.matches);
    final matchId = ModalRoute.of(context)?.settings.arguments as String;
    final isMatchDetailsLoading =
        ref.watch(providers.matches.select((_) => _.isMatchDetailsLoading));
    final matchDetails =
        ref.watch(providers.matches.select((_) => _.matchDetails));
    final List<Widget> matchPlayerWidgets = [];

    // Effects
    useEffect(
      () {
        // call matchDetail api
        matchesProvider.getMatchDetails(matchId);

        return matchesProvider.resetMatchDetails;
      },
      [],
    );

    // Methods
    final calculateTeamStats = useCallback(
      (
        int team,
        List<models.MatchPlayer> matchPlayers,
      ) {
        final teamStats = data_classes.MatchTeamStats(
          kills: 0,
          deaths: 0,
          assists: 0,
        );
        for (var matchPlayer in matchPlayers) {
          if (matchPlayer.team == team) {
            teamStats.kills += matchPlayer.playerStats.kills;
            teamStats.deaths += matchPlayer.playerStats.deaths;
            teamStats.assists += matchPlayer.playerStats.assists;
          }
        }

        return teamStats;
      },
      [],
    );

    if (isMatchDetailsLoading) {
      return const Center(
        child: widgets.LoadingIndicator(
          size: 36,
        ),
      );
    }

    if (matchDetails == null) {
      return const Center(
        child: Text('Unable to fetch details for this match'),
      );
    }

    // TODO: Optimize this shitty code
    matchPlayerWidgets.add(const MatchStats());

    for (int index = 0; index < matchDetails.matchPlayers.length; index++) {
      final matchPlayer = matchDetails.matchPlayers[index];

      if (index == 0 || index == 5) {
        final teamStats =
            calculateTeamStats(matchPlayer.team, matchDetails.matchPlayers);
        final isWinningTeam =
            matchDetails.match.winningTeam == matchPlayer.team;

        matchPlayerWidgets.add(
          MatchDetailTeamHeader(
            teamStats: teamStats,
            isWinningTeam: isWinningTeam,
            matchPlayer: matchPlayer,
          ),
        );
        matchPlayerWidgets.add(MatchPlayer(matchPlayer: matchPlayer));
      } else {
        matchPlayerWidgets.add(MatchPlayer(matchPlayer: matchPlayer));
      }
    }

    return ListView(
      children: matchPlayerWidgets,
    );
  }
}
