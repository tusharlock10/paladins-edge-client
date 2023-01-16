import "dart:ui";

import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/widgets/index.dart" as widgets;

class FeedbackImage extends HookConsumerWidget {
  final double? width;
  final double? height;
  const FeedbackImage({
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final feedbackProvider = ref.read(providers.feedback);
    final selectedImageBytes =
        ref.watch(providers.feedback.select((_) => _.selectedImageBytes));
    final isImageSelected = selectedImageBytes != null;

    return SizedBox(
      width: width,
      height: height,
      child: LayoutBuilder(builder: (context, constraints) {
        // get the image height & width of image
        // get the image height & width of textField

        final imageWidth = constraints.maxWidth;
        final imageHeight =
            imageWidth / constants.ImageAspectRatios.feedbackImage;

        return SizedBox(
          height: !isImageSelected ? imageHeight / 2 : imageHeight,
          width: imageWidth,
          child: widgets.InteractiveCard(
            elevation: 10,
            borderRadius: 10,
            disableHover: isImageSelected,
            onTap:
                isImageSelected ? () => {} : feedbackProvider.pickFeedbackImage,
            child: isImageSelected
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.memory(
                        selectedImageBytes,
                        fit: BoxFit.cover,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: SizedBox.expand(),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: InkWell(
                              onTap: feedbackProvider.pickFeedbackImage,
                              child: ClipRRect(
                                child: Container(
                                  color: Colors.black87.withOpacity(0.25),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 10,
                                      sigmaY: 10,
                                      tileMode: TileMode.mirror,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Change Image",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: theme
                                                .themeMaterialColor.shade50,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Icon(
                                          FeatherIcons.image,
                                          size: 22,
                                          color:
                                              theme.themeMaterialColor.shade50,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        FeatherIcons.image,
                        size: 36,
                      ),
                      SizedBox(height: 5),
                      Text("Select an Image"),
                    ],
                  ),
          ),
        );
      }),
    );
  }
}
