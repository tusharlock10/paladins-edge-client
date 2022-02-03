import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class _QueueCard extends StatelessWidget {
  final models.Queue queue;
  final void Function(String queueId) onTap;

  const _QueueCard({
    required this.queue,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: InkWell(
        onTap: () => onTap(queue.queueId),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              queue.name.replaceAll(RegExp('_'), ' '),
              textAlign: TextAlign.center,
              style: textTheme.bodyText1,
            ),
            const SizedBox(height: 5),
            Text(
              '${queue.activeMatchCount}',
              style: textTheme.bodyText2?.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class QueueDetails extends HookConsumerWidget {
  const QueueDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final queueProvider = ref.watch(providers.queue);

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    const itemHeight = 100;
    int crossAxisCount = 2;
    double width = size.width;
    final itemWidth = width / crossAxisCount;
    double childAspectRatio = itemWidth / itemHeight;

    // State
    final isLoading = useState(true);

    // Effects
    useEffect(
      () {
        queueProvider.getQueueDetails().then((_) => isLoading.value = false);
      },
      [],
    );

    // Methods
    final getQueueTimeline = useCallback(
      (String queueId) {
        queueProvider.getQueueTimeline(queueId);
      },
      [],
    );

    if (size.height < size.width) {
      // means in landscape mode, fix the headerHeight
      crossAxisCount = 4;
      width = size.width * 0.75;
    }

    if (isLoading.value) {
      return const widgets.LoadingIndicator(
        size: 20,
        lineWidth: 2,
        center: true,
        margin: EdgeInsets.all(20),
        label: Text('Loading Queue'),
      );
    }

    return SizedBox(
      width: width,
      child: Column(
        children: [
          Text(
            'Live Queue Numbers',
            style: textTheme.headline3,
          ),
          queueProvider.queue.isEmpty
              ? const Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        'Sorry we were unable to fetch the queue details',
                      ),
                    ),
                  ),
                )
              : GridView.count(
                  childAspectRatio: childAspectRatio,
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  children: queueProvider.queue
                      .where((_queue) => _queue.queueId != "0")
                      .map((_queue) => _QueueCard(
                            queue: _queue,
                            onTap: getQueueTimeline,
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }
}
