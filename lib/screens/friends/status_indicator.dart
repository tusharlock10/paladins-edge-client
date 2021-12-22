import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  final String status;
  const StatusIndicator({
    required this.status,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          status,
          style: theme.textTheme.bodyText1,
        ),
        Container(
          height: 10,
          width: 10,
          margin: const EdgeInsets.only(left: 7),
          decoration: BoxDecoration(
            color: status == "Offline" ? Colors.red : Colors.green,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ],
    );
  }
}
