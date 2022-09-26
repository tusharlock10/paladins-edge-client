import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/home/home_top_match_card.dart";
import "package:paladinsedge/widgets/index.dart" as widgets;

class HomeTopMatches extends HookConsumerWidget {
  const HomeTopMatches({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final isTopMatchesLoading = ref.watch(
      providers.matches.select((_) => _.isTopMatchesLoading),
    );
    final topMatches = ref.watch(
      providers.matches.select((_) => _.topMatches),
    );

    // Variables
    const itemHeight = 70.0;
    final textTheme = Theme.of(context).textTheme;

    return isTopMatchesLoading
        ? const widgets.LoadingIndicator(
            lineWidth: 2,
            size: 28,
            margin: EdgeInsets.all(20),
            label: Text("Getting Top Matches"),
          )
        : topMatches == null
            ? const Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      "Sorry we were unable to fetch top matches",
                    ),
                  ),
                ),
              )
            : Column(
                children: [
                  Text(
                    "Today's top matches",
                    style: textTheme.headline3,
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: itemHeight,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      itemCount: topMatches.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) =>
                          HomeTopMatchCard(topMatch: topMatches[index]),
                    ),
                  ),
                ],
              );
  }
}
