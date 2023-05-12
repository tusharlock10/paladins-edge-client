import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;

class FeedbackTypeSelector extends HookConsumerWidget {
  const FeedbackTypeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final feedbackProvider = ref.read(providers.feedback);
    final selectedFeedbackType = ref.watch(
      providers.feedback.select((_) => _.selectedFeedbackType),
    );

    // Variables
    final theme = Theme.of(context);

    // Hooks
    final items = useMemoized(() {
      return data_classes.FeedbackTypes.feedbackTypes.map((feedbackType) {
        final text =
            data_classes.FeedbackTypes.getFeedbackTypeText(feedbackType);

        return DropdownMenuItem(
          value: feedbackType,
          child: Text(text),
        );
      }).toList();
    });

    // Methods
    final onChanged = useCallback(
      (String? feedbackType) {
        if (feedbackType == null) return;
        feedbackProvider.changeFeedbackType(feedbackType);
      },
      [],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Select type of feedback",
          style: theme.textTheme.headlineMedium?.copyWith(fontSize: 16),
        ),
        const SizedBox(width: 20),
        DropdownButton<String>(
          items: items,
          onChanged: onChanged,
          value: selectedFeedbackType,
          iconEnabledColor: theme.textTheme.headlineMedium?.color,
          dropdownColor: theme.appBarTheme.backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          alignment: Alignment.center,
          style: theme.textTheme.displayLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
