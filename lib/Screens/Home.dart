import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../Models/index.dart' as Models;
import '../Providers/index.dart' as Providers;
import '../Widgets/index.dart' as Widgets;

class Home extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _init = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    if (this._init) {
      this._init = false;
      this.getHomeData(context);
    }

    super.didChangeDependencies();
  }

  void getHomeData(BuildContext context) async {
    final queueProvider = Provider.of<Providers.Queue>(context, listen: false);
    final bountyStoreProvider =
        Provider.of<Providers.BountyStore>(context, listen: false);
    await queueProvider.getQueueDetails();
    await bountyStoreProvider.getBountyStoreDetails();
    this.setState(() => this._isLoading = false);
  }

  Widget buildQueueCard(Models.Queue queue) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${queue.name.replaceAll(RegExp('_'), ' ')}',
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
    final queues = Provider.of<Providers.Queue>(context).queues;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    final itemHeight = 100;
    int crossAxisCount = 2;
    double width = size.width;

    if (size.height < size.width) {
      // means in landscape mode, fix the headerHeight
      crossAxisCount = 4;
      width = size.width * 0.75;
    }

    final itemWidth = width / crossAxisCount;
    double childAspectRatio = itemWidth / itemHeight;

    return Container(
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
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              children: queues.map(this.buildQueueCard).toList(),
            ),
          ],
        ));
  }

  Widget buildBountyStoreCard(Models.BountyStore bountyStore) {
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
            '${bountyStore.championName}',
            textAlign: TextAlign.center,
            style: textTheme.bodyText1,
          ),
          Text(
            '${bountyStore.skinName}',
            style: textTheme.bodyText2?.copyWith(fontSize: 16),
          ),
          Text(
            '$timeRemaining',
            style: textTheme.bodyText2?.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget buildBountyStoreDetails() {
    final bountyStore = Provider.of<Providers.BountyStore>(context).bountyStore;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    final itemHeight = 100;
    int crossAxisCount = 2;
    double width = size.width;

    if (size.height < size.width) {
      // means in landscape mode, fix the headerHeight
      crossAxisCount = 4;
      width = size.width * 0.75;
    }

    final itemWidth = width / crossAxisCount;
    double childAspectRatio = itemWidth / itemHeight;

    if (bountyStore.length == 0) {
      return SizedBox();
    }

    return Container(
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
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            children: bountyStore.map(this.buildBountyStoreCard).toList(),
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
          title: Text('Home'),
          brightness: Theme.of(context).primaryColorBrightness,
        ),
        Expanded(
          child: _isLoading
              ? Widgets.LoadingIndicator(size: 36)
              : ListView(
                  children: [
                    this.buildQueueDetails(),
                    this.buildBountyStoreDetails(),
                  ],
                ),
        )
      ],
    );
  }
}
