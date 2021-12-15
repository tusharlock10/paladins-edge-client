import 'package:flutter/material.dart';
import 'package:paladinsedge/models/index.dart' as models;

class QueueCard extends StatelessWidget {
  final models.Queue queue;

  const QueueCard({
    required this.queue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            queue.name.replaceAll(RegExp('_'), ' '),
            textAlign: TextAlign.center,
            style: textTheme.bodyText1,
          ),
          Text(
            '${queue.activeMatchCount}',
            style: textTheme.bodyText2?.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
