import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/feedback/feedback_image.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class Feedback extends HookConsumerWidget {
  static const routeName = '/feedback';

  const Feedback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final feedbackProvider = ref.read(providers.feedback);
    final selectedImage =
        ref.watch(providers.feedback.select((_) => _.selectedImage));
    final isSubmitting =
        ref.watch(providers.feedback.select((_) => _.isSubmitting));

    // Variables
    final textController = useTextEditingController();

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
        await feedbackProvider.submitFeedback(textController.text);
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
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // get the image height & width of image
                // get the image height & width of textField

                final imageWidth = constraints.maxWidth;
                final imageHeight =
                    imageWidth / constants.ImageAspectRatios.feedbackImage;
                final textFieldWidth = constraints.maxWidth;

                return Column(
                  children: [
                    SizedBox(
                      width: textFieldWidth,
                      child: Card(
                        elevation: 10,
                        clipBehavior: Clip.hardEdge,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: TextField(
                          minLines: 5,
                          maxLines: 10,
                          controller: textController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none,
                            hintText: 'Write your feedback here...',
                          ),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    FeedbackImage(
                      imageWidth: imageWidth,
                      imageHeight:
                          selectedImage == null ? imageHeight / 2 : imageHeight,
                      imagePath: selectedImage?.files.first.path,
                      onPressImage: feedbackProvider.pickFeedbackImage,
                    ),
                  ],
                );
              },
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
                  ),
          ),
        ],
      ),
    );
  }
}
