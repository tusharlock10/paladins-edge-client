import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/theme/index.dart" as theme;

class FeedbackDescription extends ConsumerWidget {
  const FeedbackDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final feedbackProvider = ref.read(providers.feedback);
    final selectedFeedbackType = ref.watch(
      providers.feedback.select((_) => _.selectedFeedbackType),
    );

    // Variables
    final isSupport =
        data_classes.FeedbackTypes.support == selectedFeedbackType;
    final cursorColor = Theme.of(context).brightness == Brightness.dark
        ? theme.darkThemeMaterialColor.shade50
        : null;

    return Card(
      elevation: 10,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
            ),
            child: const Text(
              "Description",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                textSelectionTheme: TextSelectionThemeData(
                  cursorColor: cursorColor,
                  selectionColor: cursorColor,
                  selectionHandleColor: cursorColor,
                ),
              ),
              child: TextField(
                minLines: null,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                expands: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  border: InputBorder.none,
                  hintText: isSupport
                      ? "Describe your issue here..."
                      : "Write your feedback here...",
                ),
                style: const TextStyle(fontSize: 18),
                onChanged: feedbackProvider.changeDescription,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
