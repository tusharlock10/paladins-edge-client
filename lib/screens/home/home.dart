import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/home/home_favourite_friends.dart";
import "package:paladinsedge/screens/home/home_player_timed_stats.dart";
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
    final topMatchesProvider = ref.read(providers.topMatches);
    final favouriteFriends = ref.watch(
      providers.auth.select((_) => _.user?.favouriteFriends),
    );
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));
    final player = ref.watch(providers.auth.select((_) => _.userPlayer));
    final friendProvider = player != null
        ? ref.read(
            providers.friends(player.playerId),
          )
        : null;

    // State
    final isRefreshing = useState(false);

    // Effects
    useEffect(
      () {
        queueProvider.getQueueTimeline(false);
        topMatchesProvider.loadTopMatches(false);

        return;
      },
      [],
    );

    // Methods
    final onRefresh = useCallback(
      () async {
        isRefreshing.value = true;
        await Future.wait([
          queueProvider.getQueueTimeline(true),
          topMatchesProvider.loadTopMatches(true),
          if (friendProvider != null) friendProvider.getFriends(),
        ]);
        isRefreshing.value = false;
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
            pinned: !constants.isMobile,
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
                    isRefreshing: isRefreshing.value,
                  ),
                ),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                const widgets.ApiStatusMessage(
                  paladinsApiUnavailableMessage:
                      "You won't be able to view updated data as Paladins services are down. Please try again later",
                  serverMaintenanceMessage:
                      "Our servers will be up soon. Please try again later",
                ),
                if (!isGuest) const SizedBox(height: 20),
                if (!isGuest) const HomeFavouriteFriends(),
                if (player != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: HomePlayerTimedStats(playerId: player.playerId),
                  ),
                const SizedBox(height: 20),
                const HomeTopMatches(),
                const SizedBox(height: 20),
                const HomeQueueDetails(),
                const SizedBox(height: 20),
                const HomeQueueChart(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
