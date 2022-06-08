import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/player_detail/player_detail_match_card.dart";
import "package:paladinsedge/widgets/index.dart" as widgets;

class PlayerDetailMatches extends HookConsumerWidget {
  const PlayerDetailMatches({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final isPlayerMatchesLoading = ref.watch(
      providers.matches.select((_) => _.isPlayerMatchesLoading),
    );
    final combinedMatches = ref.watch(
      providers.matches.select((_) => _.combinedMatches),
    );
    final champions = ref.read(providers.champions).champions;

    // Hooks
    final filteredCombinedMatches = useMemoized(
      () {
        return combinedMatches?.where((_) => !_.hide);
      },
      [combinedMatches],
    );

    if (isPlayerMatchesLoading) {
      return const widgets.LoadingIndicator(
        lineWidth: 2,
        size: 28,
        label: Text("Getting matches"),
      );
    }

    return filteredCombinedMatches == null
        ? const Center(
            child: Text("Unable to fetch matches for this player"),
          )
        : ListView.builder(
            itemCount: filteredCombinedMatches.length,
            padding: const EdgeInsets.only(top: 80, bottom: 50),
            itemExtent: PlayerDetailMatchCard.itemExtent,
            itemBuilder: (context, index) {
              final combinedMatch = filteredCombinedMatches.elementAt(index);
              final match = combinedMatch.match;
              final matchPlayer = combinedMatch.matchPlayers.firstOrNullWhere(
                (_) => _.matchId == match.matchId,
              );
              final champion = champions.firstOrNullWhere(
                (_) => _.championId == matchPlayer?.championId,
              );

              return PlayerDetailMatchCard(
                matchPlayer: matchPlayer,
                champion: champion,
                match: match,
              );
            },
          );
  }
}
