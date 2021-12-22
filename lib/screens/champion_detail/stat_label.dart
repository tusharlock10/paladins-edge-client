import 'package:flutter/material.dart';

class StatLabel extends StatelessWidget {
  final String label;
  final String text;

  const StatLabel({
    required this.label,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.primaryColor.withOpacity(0.5),
      margin: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: theme.textTheme.headline1
                ?.copyWith(fontSize: 18, color: Colors.white),
          ),
          Text(
            text,
            style: theme.textTheme.headline1?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
