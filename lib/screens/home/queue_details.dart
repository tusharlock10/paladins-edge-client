import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/home/queue_card.dart';

class QueueDetails extends ConsumerWidget {
  const QueueDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queue = ref.watch(providers.queue.select((_) => _.queue));

    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    const itemHeight = 100;
    int crossAxisCount = 2;
    double width = size.width;

    if (size.height < size.width) {
      // means in landscape mode, fix the headerHeight
      crossAxisCount = 4;
      width = size.width * 0.75;
    }

    final itemWidth = width / crossAxisCount;
    double childAspectRatio = itemWidth / itemHeight;

    return SizedBox(
        width: width,
        child: Column(
          children: [
            Text(
              'Live Queue Details',
              style: textTheme.headline3,
            ),
            GridView.count(
                childAspectRatio: childAspectRatio,
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                children: queue
                    .map(
                      (_queue) => QueueCard(queue: _queue),
                    )
                    .toList()),
          ],
        ));
  }
}
