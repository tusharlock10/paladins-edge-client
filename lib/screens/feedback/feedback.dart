import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/feedback/feedback_input_landscape.dart";
import "package:paladinsedge/screens/feedback/feedback_input_portrait.dart";
import "package:paladinsedge/screens/feedback/feedback_support_contact.dart";
import "package:paladinsedge/screens/feedback/feedback_type_selector.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class Feedback extends HookConsumerWidget {
  static const routeName = "feedback";
  static const routePath = "feedback";
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    pageBuilder: _routeBuilder,
  );

  static const connectProfileRouteName = "connect-profile-feedback";
  static const connectProfileRoutePath = "feedback";
  static final connectProfileGoRoute = GoRoute(
    name: connectProfileRouteName,
    path: connectProfileRoutePath,
    pageBuilder: _routeBuilder,
  );

  const Feedback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final feedbackProvider = ref.read(providers.feedback);
    final selectedFeedbackType = ref.watch(
      providers.feedback.select((_) => _.selectedFeedbackType),
    );
    final isSubmitting = ref.watch(
      providers.feedback.select((_) => _.isSubmitting),
    );
    final description = ref.watch(
      providers.feedback.select((_) => _.description),
    );

    // Variables
    final isSupport =
        selectedFeedbackType == data_classes.FeedbackTypes.support;

    // Effects
    useEffect(
      () {
        // clear data on screen un-mount
        return feedbackProvider.clearData;
      },
      [],
    );

    // Methods
    final goBack = useCallback(
      () {
        utilities.Navigation.pop(context);
      },
      [],
    );

    final onSubmitFail = useCallback(
      () {
        widgets.showToast(
          context: context,
          text: isSupport
              ? "Unable to submit support ticket"
              : "Unable to submit feedback",
          type: widgets.ToastType.error,
        );
      },
      [],
    );

    final onSubmitSuccess = useCallback(
      () {
        widgets.showToast(
          context: context,
          text: isSupport
              ? "We'll get back to you soon"
              : "Thank you for feedback",
          type: widgets.ToastType.success,
        );
      },
      [],
    );

    final onSubmit = useCallback(
      () async {
        final result = await feedbackProvider.submitFeedback();

        if (!result) return onSubmitFail();

        goBack();
        onSubmitSuccess();
      },
      [isSupport],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(isSupport ? "Support Ticket" : "Provide Feedback"),
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
          const SizedBox(height: 15),
          const FeedbackSupportContact(),
          const SizedBox(height: 30),
          Center(
            child: isSubmitting
                ? const widgets.LoadingIndicator(
                    lineWidth: 2,
                    size: 28,
                    label: Text("Submitting"),
                  )
                : widgets.Button(
                    label: "Submit",
                    onPressed: onSubmit,
                    disabled: description.length < 10,
                  ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  static Page _routeBuilder(_, __) => const CupertinoPage(child: Feedback());
}
