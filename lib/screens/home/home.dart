import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/home/home_bounty_store_details.dart";
import "package:paladinsedge/screens/home/home_favourite_friends.dart";
import "package:paladinsedge/screens/home/home_queue_chart.dart";
import "package:paladinsedge/screens/home/home_queue_details.dart";
import "package:paladinsedge/screens/home/home_top_matches.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class Home extends HookConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  Providers
    final queueProvider = ref.read(providers.queue);
    final itemsProvider = ref.read(providers.items);
    final matchesProvider = ref.read(providers.matches);
    final bountyStoreProvider = ref.read(providers.bountyStore);
    final friendsProvider = ref.read(providers.friends);
    final favouriteFriends = ref.watch(
      providers.auth.select((_) => _.user?.favouriteFriendIds),
    );
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));

    // Effects
    useEffect(
      () {
        bountyStoreProvider.loadBountyStore(false);
        queueProvider.getQueueTimeline(false);
        itemsProvider.loadItems(false);
        matchesProvider.loadTopMatches(false);

        return;
      },
      [],
    );

    // Methods
    final onRefresh = useCallback(
      () async {
        return await Future.wait([
          bountyStoreProvider.loadBountyStore(true),
          queueProvider.getQueueTimeline(true),
          itemsProvider.loadItems(true),
          matchesProvider.loadTopMatches(true),
          if (favouriteFriends != null)
            friendsProvider.getFavouriteFriends(true),
        ]);
      },
      [favouriteFriends],
    );

    return widgets.Refresh(
      onRefresh: onRefresh,
      edgeOffset: utilities.getTopEdgeOffset(context),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            floating: true,
            forceElevated: true,
            pinned: constants.isWeb,
            title: const Text(
              "Paladins Edge",
              style: TextStyle(fontSize: 20),
            ),
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: widgets.RefreshButton(
                    color: Colors.white,
                    onRefresh: onRefresh,
                  ),
                ),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                if (!isGuest) const SizedBox(height: 20),
                if (!isGuest) const HomeFavouriteFriends(),
                const SizedBox(height: 20),
                const HomeTopMatches(),
                const SizedBox(height: 20),
                const HomeQueueDetails(),
                const SizedBox(height: 20),
                const HomeQueueChart(),
                const SizedBox(height: 20),
                const HomeBountyStoreDetails(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
