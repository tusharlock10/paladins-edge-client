import 'package:flutter/material.dart';

class Refresh extends StatelessWidget {
  final Widget child;
  final RefreshCallback onRefresh;
  final double edgeOffset;

  const Refresh({
    required this.child,
    required this.onRefresh,
    this.edgeOffset = 0.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child,
      onRefresh: onRefresh,
      edgeOffset: edgeOffset,
      backgroundColor: Theme.of(context).cardTheme.color,
      color: Theme.of(context).textTheme.headline1?.color,
    );
  }
}
