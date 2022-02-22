import 'package:flutter/material.dart';

/// A row whose children can be reversed
class ReversibleRow extends StatelessWidget {
  final bool shouldReverse;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;

  const ReversibleRow({
    required this.shouldReverse,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return shouldReverse
        ? Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: children.reversed.toList(),
          )
        : Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: children,
          );
  }
}
