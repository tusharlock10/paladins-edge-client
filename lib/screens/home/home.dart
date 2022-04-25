import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/home/home_bounty_store_details.dart';
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
    final queueProvider = ref.read(providers.queue);
    final bountyStoreProvider = ref.read(providers.bountyStore);

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
        ]);
      },
      [],
    );

    return widgets.Refresh(
      onRefresh: onRefresh,
      edgeOffset: utilities.getTopEdgeOffset(context),
      child: const CustomScrollView(
        slivers: [
          SliverAppBar(
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
                SizedBox(height: 20),
                HomeQueueDetails(),
                HomeQueueChart(),
                HomeBountyStoreDetails(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
