import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/home/home_bounty_store_details.dart';
import 'package:paladinsedge/screens/home/home_favourite_friends.dart';
import 'package:paladinsedge/screens/home/home_queue_chart.dart';
import 'package:paladinsedge/screens/home/home_queue_details.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class Home extends HookConsumerWidget {
  static const routeName = '/home';

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  Providers
    final favouriteFriends =
        ref.watch(providers.auth.select((_) => _.user?.favouriteFriends));
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));
    final queueProvider = ref.read(providers.queue);
    final bountyStoreProvider = ref.read(providers.bountyStore);
    final playersProvider = ref.read(providers.players);

    // Effects
    useEffect(
      () {
        bountyStoreProvider.loadBountyStore(false);
        queueProvider.getQueueTimeline(false);

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
          if (favouriteFriends != null)
            playersProvider.getFavouriteFriends(true),
        ]);
      },
      [favouriteFriends],
    );

    return widgets.Refresh(
      onRefresh: onRefresh,
      edgeOffset: utilities.getTopEdgeOffset(context),
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            snap: true,
            floating: true,
            forceElevated: true,
            pinned: constants.isWeb,
            title: Text(
              'Paladins Edge',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                if (!isGuest) const SizedBox(height: 20),
                if (!isGuest) const HomeFavouriteFriends(),
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
