import "package:flutter/material.dart";
import "package:paladinsedge/constants.dart" as constants;
import "package:paladinsedge/screens/feedback/feedback_description.dart";
import "package:paladinsedge/screens/feedback/feedback_image.dart";

class FeedbackInputLandscape extends StatelessWidget {
  const FeedbackInputLandscape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageWidth = constraints.maxWidth * 0.3;
        final imageHeight =
            imageWidth / constants.ImageAspectRatios.feedbackImage;
        final textFieldHeight = imageHeight;
        final textFieldWidth = constraints.maxWidth - 10 - imageWidth;

        return Row(
          children: [
            Flexible(
              flex: 25,
              child: FeedbackDescription(
                width: textFieldWidth,
                height: textFieldHeight,
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 10,
              child: FeedbackImage(
                width: imageWidth,
                height: imageHeight,
              ),
            ),
          ],
        );
      },
    );
  }
}
