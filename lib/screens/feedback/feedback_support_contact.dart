import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;

class FeedbackSupportContact extends HookConsumerWidget {
  const FeedbackSupportContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final email = ref.watch(
      providers.auth.select((_) => _.user?.email),
    );
    final selectedFeedbackType = ref.watch(
      providers.feedback.select((_) => _.selectedFeedbackType),
    );

    // Variables
    final isSupport =
        selectedFeedbackType == data_classes.FeedbackTypes.support;
    final textTheme = Theme.of(context).textTheme;

    if (!isSupport) {
      return const SizedBox();
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Text(
          email == null
              ? "NOTE: Please make sure you insert your email in the description so we can contact you"
              : "*We'll contact you on $email",
          textAlign: TextAlign.center,
          style: textTheme.bodyText1,
        ),
      ),
    );
  }
}
