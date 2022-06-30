import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/saved_matches/saved_matches_list.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class SavedMatches extends HookConsumerWidget {
  static const routeName = "savedMatches";
  static const routePath = "savedMatches";

  const SavedMatches({Key? key}) : super(key: key);

  static GoRoute goRouteBuilder(List<GoRoute> routes) => GoRoute(
        name: routeName,
        path: routePath,
        pageBuilder: _routeBuilder,
        routes: routes,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final authProvider = ref.read(providers.auth);
    final savedMatches =
        ref.watch(providers.auth.select((_) => _.savedMatches));

    // Effects
    useEffect(
      () {
        if (savedMatches == null) {
          authProvider.getSavedMatches();
        }

        return;
      },
      [],
    );

    return Scaffold(
      body: widgets.Refresh(
        onRefresh: authProvider.getSavedMatches,
        edgeOffset: utilities.getTopEdgeOffset(context),
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              forceElevated: true,
              floating: true,
              snap: true,
              pinned: constants.isWeb,
              title: Text("Saved Matches"),
            ),
            savedMatches == null || savedMatches.isEmpty
                ? SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        SizedBox(
                          height: utilities.getBodyHeight(context),
                          child: Center(
                            child: savedMatches == null
                                ? const widgets.LoadingIndicator(
                                    lineWidth: 2,
                                    size: 28,
                                    label: Text("Getting Matches"),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "You have not saved any matches",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Open a match from a player's profile\nand click on the Save Match button",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SavedMatchesList(),
          ],
        ),
      ),
    );
  }

  static Page _routeBuilder(_, __) =>
      const CupertinoPage(child: SavedMatches());
}
