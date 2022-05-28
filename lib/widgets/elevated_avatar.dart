import "package:flutter/material.dart";
import "package:paladinsedge/widgets/index.dart" as widgets;

class ElevatedAvatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  final String? imageBlurHash;
  final double? borderRadius;
  final double? borderWidth;
  final double? elevation;
  final BoxFit? fit;

  const ElevatedAvatar({
    required this.imageUrl,
    required this.size,
    this.imageBlurHash,
    this.borderWidth,
    this.elevation,
    this.borderRadius,
    this.fit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? size / 2;

    return SizedBox(
      height: size * 2,
      width: size * 2,
      child: Material(
        color: Theme.of(context).cardTheme.color,
        clipBehavior: Clip.antiAlias,
        elevation: elevation ?? 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: widgets.FastImage(
          imageUrl: imageUrl,
          imageBlurHash: imageBlurHash,
          fit: fit,
        ),
      ),
    );
  }
}
