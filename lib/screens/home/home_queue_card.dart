import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/theme/index.dart' as theme;

class HomeQueueCard extends HookWidget {
  final models.Queue queue;
  final bool isSelected;
  final void Function(int queueId) onTap;

  const HomeQueueCard({
    required this.queue,
    required this.isSelected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;
    final brightness = Theme.of(context).brightness;

    // State
    final isHovered = useState(false);

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      child: Card(
        elevation: isSelected ? 2 : 7,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: DecoratedBox(
          decoration: isHovered.value
              ? BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    width: 3,
                    color: brightness == Brightness.light
                        ? theme.themeMaterialColor
                        : theme.themeMaterialColor.shade50,
                  ),
                )
              : const BoxDecoration(),
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
                isSelected
                    ? Text(
                        'Selected',
                        style: textTheme.bodyText1?.copyWith(
                          fontSize: 12,
                          color: brightness == Brightness.light
                              ? theme.themeMaterialColor
                              : theme.themeMaterialColor.shade50,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
