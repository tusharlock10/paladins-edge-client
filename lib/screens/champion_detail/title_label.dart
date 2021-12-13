import 'package:flutter/material.dart';

class TitleLabel extends StatelessWidget {
  final String label;

  const TitleLabel({
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15),
        child: Container(
          padding: const EdgeInsets.only(left: 7, right: 10),
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.5,
                color: theme.colorScheme.secondary,
              ),
            ),
          ),
          child: Text(
            label,
            style: theme.textTheme.headline2?.copyWith(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
