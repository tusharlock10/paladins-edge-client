import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/player_detail/player_match_card.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class PlayerMatches extends ConsumerWidget {
  const PlayerMatches({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlayerMatchesLoading =
        ref.watch(providers.matches.select((_) => _.isPlayerMatchesLoading));
    final playerMatches =
        ref.watch(providers.matches.select((_) => _.playerMatches));
    final champions = ref.read(providers.champions).champions;

    if (isPlayerMatchesLoading) {
      return const widgets.LoadingIndicator(size: 36);
    }

    if (playerMatches == null) {
      return const Center(
        child: Text('Unable to fetch matches for this player'),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: playerMatches.matchPlayers.length,
      itemBuilder: (context, index) {
        final matchPlayer = playerMatches.matchPlayers[index];

        // find the match that is associated with that matchPlayer
        final match = playerMatches.matches
            .firstOrNullWhere((_) => _.matchId == matchPlayer.matchId);

        // champion that this player played in the match
        final champion = champions.firstOrNullWhere(
          (_) => _.championId == matchPlayer.championId.toString(),
        );

        if (match == null || champion == null) {
          return const SizedBox();
        }

        return PlayerMatchCard(
          matchPlayer: matchPlayer,
          champion: champion,
          match: match,
        );
      },
    );
  }
}
