import 'package:flutter/material.dart';
import 'package:paladinsedge/api/index.dart' as api;

class LowerSearchItem extends StatelessWidget {
  final api.LowerSearch lowerSearch;

  const LowerSearchItem({
    required this.lowerSearch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        lowerSearch.name,
        style: Theme.of(context).primaryTextTheme.headline6,
      ),
    );
  }
}
