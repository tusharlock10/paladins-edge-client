import "package:dartx/dartx.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/player_detail/player_detail_match_card.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;

class SavedMatchesList extends HookConsumerWidget {
  const SavedMatchesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final champions = ref.watch(providers.champions.select((_) => _.champions));
    final savedMatches = ref.watch(
      providers.auth.select((_) => _.savedMatches),
    );

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

    return savedMatches == null
        ? const SizedBox()
        : SliverPadding(
            padding: EdgeInsets.only(
              top: 15,
              bottom: 50,
              right: horizontalPadding,
              left: horizontalPadding,
            ),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisExtent: PlayerDetailMatchCard.itemExtent,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  final combinedMatch = savedMatches.elementAt(index);
                  final match = combinedMatch.match;
                  final matchPlayer =
                      combinedMatch.matchPlayers.firstOrNullWhere(
                    (_) => _.matchId == match.matchId,
                  );
                  final champion = champions.firstOrNullWhere(
                    (_) => _.championId == matchPlayer?.championId,
                  );

                  return PlayerDetailMatchCard(
                    matchPlayer: matchPlayer,
                    champion: champion,
                    match: match,
                    isSavedMatch: true,
                  );
                },
                childCount: savedMatches.length,
              ),
            ),
          );
  }
}
