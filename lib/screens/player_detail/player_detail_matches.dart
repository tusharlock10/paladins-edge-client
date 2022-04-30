import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/player_detail/player_detail_match_card.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class PlayerDetailMatches extends ConsumerWidget {
  const PlayerDetailMatches({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlayerMatchesLoading =
        ref.watch(providers.matches.select((_) => _.isPlayerMatchesLoading));
    final playerMatches =
        ref.watch(providers.matches.select((_) => _.playerMatches));
    final champions = ref.read(providers.champions).champions;

    if (isPlayerMatchesLoading) {
      return const widgets.LoadingIndicator(
        lineWidth: 2,
        size: 28,
        label: Text('Getting matches'),
      );
    }

    return playerMatches == null
        ? const Center(
            child: Text('Unable to fetch matches for this player'),
          )
        : ListView.builder(
            itemCount: playerMatches.matches.length,
            padding: const EdgeInsets.only(top: 108, bottom: 50),
            itemBuilder: (context, index) {
              final match = playerMatches.matches[index];

              // find the match that is associated with that matchPlayer
              final matchPlayer = playerMatches.matchPlayers
                  .firstOrNullWhere((_) => _.matchId == match.matchId);

              // champion that this player played in the match
              final champion = champions.firstOrNullWhere(
                (_) => _.championId == matchPlayer?.championId,
              );

              if (matchPlayer == null || champion == null) {
                return const SizedBox();
              }

              return PlayerDetailMatchCard(
                matchPlayer: matchPlayer,
                champion: champion,
                match: match,
              );
            },
          );
  }
}
