import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/feedback/feedback_input_landscape.dart';
import 'package:paladinsedge/screens/feedback/feedback_input_portrait.dart';
import 'package:paladinsedge/screens/feedback/feedback_type_selector.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class Feedback extends HookConsumerWidget {
  static const routeName = '/feedback';

  const Feedback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final feedbackProvider = ref.read(providers.feedback);
    final isSubmitting =
        ref.watch(providers.feedback.select((_) => _.isSubmitting));
    final description =
        ref.watch(providers.feedback.select((_) => _.description));

    // Effects
    useEffect(
      () {
        // clear data on screen un-mount
        return feedbackProvider.clearData;
      },
      [],
    );

    // Methods
    final onSubmit = useCallback(
      () async {
        await feedbackProvider.submitFeedback();
        Navigator.of(context).pop();
        widgets.showToast(
          context: context,
          text: 'Thank you for feedback',
          type: widgets.ToastType.success,
        );
      },
      [],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provide Feedback'),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 20),
          const FeedbackTypeSelector(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: utilities.responsiveCondition(
              context,
              desktop: const FeedbackInputLandscape(),
              tablet: const FeedbackInputLandscape(),
              mobile: const FeedbackInputPortrait(),
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: isSubmitting
                ? const widgets.LoadingIndicator(
                    size: 28,
                    label: Text('Submitting'),
                  )
                : widgets.Button(
                    label: 'Submit',
                    onPressed: onSubmit,
                    disabled: description.length < 10,
                  ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}