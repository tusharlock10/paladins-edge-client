import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _init = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      _init = false;
      getHomeData(context);
    }

    super.didChangeDependencies();
  }

  void getHomeData(BuildContext context) async {
    final queueProvider = Provider.of<providers.Queue>(context, listen: false);
    final bountyStoreProvider =
        Provider.of<providers.BountyStore>(context, listen: false);
    await queueProvider.getQueueDetails();
    await bountyStoreProvider.getBountyStoreDetails();
    setState(() => _isLoading = false);
  }

  Widget buildQueueCard(models.Queue queue) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            queue.name.replaceAll(RegExp('_'), ' '),
            textAlign: TextAlign.center,
            style: textTheme.bodyText1,
          ),
          Text(
            '${queue.activeMatchCount}',
            style: textTheme.bodyText2?.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildQueueDetails() {
    final queues = Provider.of<providers.Queue>(context).queues;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    const itemHeight = 100;
    int crossAxisCount = 2;
    double width = size.width;

    if (size.height < size.width) {
      // means in landscape mode, fix the headerHeight
      crossAxisCount = 4;
      width = size.width * 0.75;
    }

    final itemWidth = width / crossAxisCount;
    double childAspectRatio = itemWidth / itemHeight;

    return SizedBox(
        width: width,
        child: Column(
          children: [
            Text(
              'Live Queue Details',
              style: textTheme.headline3,
            ),
            GridView.count(
              childAspectRatio: childAspectRatio,
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              children: queues.map(buildQueueCard).toList(),
            ),
          ],
        ));
  }

  Widget buildBountyStoreCard(models.BountyStore bountyStore) {
    final textTheme = Theme.of(context).textTheme;
    final timeDiff = bountyStore.endDate.difference(DateTime.now());
    final endTime = timeDiff.toString();
    final endDays = timeDiff.inDays;
    String timeRemaining;

    if (endDays == 0) {
      timeRemaining = '$endTime remaining';
    } else {
      timeRemaining = '$endDays days remaining';
    }

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            bountyStore.championName,
            textAlign: TextAlign.center,
            style: textTheme.bodyText1,
          ),
          Text(
            bountyStore.skinName,
            style: textTheme.bodyText2?.copyWith(fontSize: 16),
          ),
          Text(
            timeRemaining,
            style: textTheme.bodyText2?.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget buildBountyStoreDetails() {
    const itemHeight = 100;

    final bountyStore = Provider.of<providers.BountyStore>(context).bountyStore;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    int crossAxisCount = 2;
    double width = size.width;

    if (size.height < size.width) {
      // means in landscape mode, fix the headerHeight
      crossAxisCount = 4;
      width = size.width * 0.75;
    }

    final itemWidth = width / crossAxisCount;
    double childAspectRatio = itemWidth / itemHeight;

    if (bountyStore.isEmpty) {
      return const SizedBox();
    }

    return SizedBox(
      width: width,
      child: Column(
        children: [
          Text(
            'Bounty Store Updates',
            style: textTheme.headline3,
          ),
          GridView.count(
            childAspectRatio: childAspectRatio,
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            children: bountyStore.map(buildBountyStoreCard).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text('Home'),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Theme.of(context).primaryColorBrightness),
        ),
        Expanded(
          child: _isLoading
              ? const widgets.LoadingIndicator(size: 36)
              : ListView(
                  children: [
                    buildQueueDetails(),
                    buildBountyStoreDetails(),
                  ],
                ),
        )
      ],
    );
  }
}
