import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class FeedbackImage extends StatelessWidget {
  final double imageWidth;
  final double imageHeight;
  final String? imagePath;
  final void Function() onPressImage;

  const FeedbackImage({
    required this.imageWidth,
    required this.imageHeight,
    required this.imagePath,
    required this.onPressImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imageHeight,
      width: imageWidth,
      child: Card(
        elevation: 10,
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: widgets.Ripple(
          onTap: imagePath != null ? () => {} : onPressImage,
          child: imagePath != null
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(
                      File(imagePath!),
                      fit: BoxFit.cover,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: SizedBox.expand(),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: widgets.Ripple(
                            onTap: onPressImage,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Change Image",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color:
                                              theme.themeMaterialColor.shade50,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Icon(
                                        FeatherIcons.image,
                                        size: 22,
                                        color: theme.themeMaterialColor.shade50,
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
      ),
    );
  }
}
