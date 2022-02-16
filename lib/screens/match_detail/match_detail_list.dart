import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/match_detail/match_detail_team_header.dart';
import 'package:paladinsedge/screens/match_detail/match_player.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class MatchDetailList extends HookConsumerWidget {
  static const routeName = '/matchDetail';

  const MatchDetailList({Key? key}) : super(key: key);

  Map<String, int> calculateTeamStats(
    int team,
    List<models.MatchPlayer> matchPlayers,
  ) {
    int kills = 0;
    int deaths = 0;
    int assists = 0;

    for (var matchPlayer in matchPlayers) {
      if (matchPlayer.team == team) {
        kills += matchPlayer.playerStats.kills;
        deaths += matchPlayer.playerStats.deaths;
        assists += matchPlayer.playerStats.assists;
      }
    }

    return {
      'kills': kills,
      'deaths': deaths,
      'assists': assists,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchesProvider = ref.read(providers.matches);
    final matchId = ModalRoute.of(context)?.settings.arguments as String;
    final isMatcheDetailsLoading =
        ref.watch(providers.matches.select((_) => _.isMatcheDetailsLoading));
    final matchDetails =
        ref.watch(providers.matches.select((_) => _.matchDetails));

    // Effects
    useEffect(
      () {
        // call matchDetail api
        matchesProvider.getMatchDetails(matchId);

        return matchesProvider.resetMatchDetails;
      },
      [],
    );

    final List<Widget> matchPlayerWidgets = [];

    if (isMatcheDetailsLoading) {
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
