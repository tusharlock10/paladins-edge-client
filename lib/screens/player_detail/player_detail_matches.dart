import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/player_detail/player_detail_match_card.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;
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

    // Variables
    final size = MediaQuery.of(context).size;
    final crossAxisCount = utilities.responsiveCondition(
      context,
      desktop: 2,
      tablet: 2,
      mobile: 1,
    );
    final horizontalPadding = utilities
        .responsiveCondition(
          context,
          desktop: (size.width * 0.15) / 2,
          tablet: 0,
          mobile: 0,
        )
        .toDouble();

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
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisExtent: PlayerDetailMatchCard.itemExtent,
            ),
            itemCount: filteredCombinedMatches.length,
            padding: EdgeInsets.only(
              top: 80,
              bottom: 50,
              right: horizontalPadding,
              left: horizontalPadding,
            ),
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
