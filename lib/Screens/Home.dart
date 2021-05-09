import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../Providers/index.dart' as Providers;
import '../Models/index.dart' as Models;

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
      this.getQueueDetails(context);
    }

    super.didChangeDependencies();
  }

  void getQueueDetails(BuildContext context) async {
    final queueProvider = Provider.of<Providers.Queue>(context, listen: false);
    await queueProvider.getQueueDetails();
    this.setState(() => this._isLoading = false);
  }

  Widget buildQueueCard(Models.Queue queue) {
    return Card(
      child: Column(
        children: [
          Text('${queue.name.replaceAll(RegExp('_'), ' ')}'),
          Text('${queue.activeMatchCount}'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final queues = Provider.of<Providers.Queue>(context).queues;
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

    return Column(
      children: [
        AppBar(
          title: Text('Home'),
          brightness: Theme.of(context).primaryColorBrightness,
        ),
        Expanded(
          child: Container(
            width: width,
            child: GridView.count(
              childAspectRatio: childAspectRatio,
              crossAxisCount: crossAxisCount,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              children: queues.map(this.buildQueueCard).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
