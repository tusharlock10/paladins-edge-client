import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class ConnectProfileVerifyHelp extends HookConsumerWidget {
  const ConnectProfileVerifyHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final feedbackProvider = ref.read(providers.feedback);

    // Variables
    final textTheme = Theme.of(context).textTheme;

    // Methods
    final onTap = useCallback(
      () {
        feedbackProvider.changeFeedbackType(data_classes.FeedbackTypes.support);
        utilities.Navigation.navigate(
          context,
          screens.Feedback.connectProfileRouteName,
        );
      },
      [],
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Having problems verifying?",
              style: textTheme.displayLarge?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 15),
            const Text("Make sure that-"),
            const SizedBox(height: 7),
            const Text("1. You didn't forget to save the loadout"),
            const SizedBox(height: 7),
            const Text("2. Your \"Public Profile\" is set to enabled"),
            const Text("Check it in Settings > Gameplay in Paladins"),
            const SizedBox(height: 7),
            const Text("2. Your \"Public Profile\" is set to enabled"),
            const Text("Check it in Settings > Gameplay in Paladins"),
            const SizedBox(height: 7),
            const Text(
              "3. Try logout and login again in Paladins Edge and retry",
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                widgets.InteractiveText(
                  "Raise a support ticket if your are still stuck",
                  onTap: onTap,
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
