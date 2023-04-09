import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/widgets/index.dart" as widgets;

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

    return widgets.InteractiveCard(
      elevation: isSelected ? 2 : 7,
      borderRadius: 10,
      onTap: () => onTap(queue.queueId),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            queue.name.replaceAll(RegExp("_"), " "),
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge,
          ),
          const SizedBox(height: 5),
          Text(
            "${queue.activeMatchCount}",
            style: textTheme.bodyMedium?.copyWith(fontSize: 16),
          ),
          isSelected
              ? Text(
                  "Selected",
                  style: textTheme.bodyLarge?.copyWith(
                    fontSize: 12,
                    color: brightness == Brightness.light
                        ? theme.themeMaterialColor
                        : theme.themeMaterialColor.shade50,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
