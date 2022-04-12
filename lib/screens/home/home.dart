import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paladinsedge/screens/home/bounty_store_details.dart';
import 'package:paladinsedge/screens/home/queue_chart.dart';
import 'package:paladinsedge/screens/home/queue_details.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          snap: true,
          floating: true,
          elevation: 4,
          forceElevated: true,
          title: const Text(
            'Paladins Edge',
            style: TextStyle(fontSize: 20),
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Theme.of(context).brightness,
          ),
        ),
        const SliverList(
          delegate: SliverChildListDelegate.fixed(
            [
              SizedBox(height: 20),
              QueueDetails(),
              QueueChart(),
              BountyStoreDetails(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
