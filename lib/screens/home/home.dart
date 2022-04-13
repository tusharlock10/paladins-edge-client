import 'package:flutter/material.dart';
import 'package:paladinsedge/screens/home/home_bounty_store_details.dart';
import 'package:paladinsedge/screens/home/home_queue_chart.dart';
import 'package:paladinsedge/screens/home/home_queue_details.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverAppBar(
          snap: true,
          floating: true,
          forceElevated: true,
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
    );
  }
}
