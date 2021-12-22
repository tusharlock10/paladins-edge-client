import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/home/bounty_store_details.dart';
import 'package:paladinsedge/screens/home/queue_details.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class Home extends ConsumerStatefulWidget {
  static const routeName = '/home';
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  bool _init = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      _init = false;
      getHomeData();
    }

    super.didChangeDependencies();
  }

  void getHomeData() async {
    final queueProvider = ref.read(providers.queue);
    final bountyStoreProvider = ref.read(providers.bountyStore);

    await queueProvider.getQueueDetails();
    await bountyStoreProvider.loadBountyStore();

    setState(() => _isLoading = false);
  }

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
          child: _isLoading
              ? const widgets.LoadingIndicator(size: 36)
              : ListView(
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
