import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/index.dart' as Providers;

class PlayerDetail extends StatelessWidget {
  static const routeName = '/playerDetail';

  @override
  Widget build(BuildContext context) {
    final searchData = Provider.of<Providers.Search>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Player Details'),
      ),
      body: Center(
        child: Text('${searchData.playerData?.name}'),
      ),
    );
  }
}
