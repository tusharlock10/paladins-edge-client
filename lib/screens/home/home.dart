import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paladinsedge/screens/home/bounty_store_details.dart';
import 'package:paladinsedge/screens/home/queue_details.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text('Home'),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Theme.of(context).primaryColorBrightness,
          ),
        ),
        Expanded(
          child: ListView(
            children: const [
              QueueDetails(),
              BountyStoreDetails(),
            ],
          ),
        ),
      ],
    );
  }
}
