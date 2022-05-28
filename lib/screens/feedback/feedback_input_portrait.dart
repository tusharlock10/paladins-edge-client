import "package:flutter/material.dart";
import "package:paladinsedge/screens/feedback/feedback_description.dart";
import "package:paladinsedge/screens/feedback/feedback_image.dart";

class FeedbackInputPortrait extends StatelessWidget {
  const FeedbackInputPortrait({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        FeedbackDescription(height: 200),
        SizedBox(height: 15),
        FeedbackImage(),
      ],
    );
  }
}
