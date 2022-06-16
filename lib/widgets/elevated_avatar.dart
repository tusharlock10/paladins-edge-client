import "package:flutter/material.dart";
import "package:paladinsedge/widgets/index.dart" as widgets;

class ElevatedAvatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  final BoxFit fit;
  final String? imageBlurHash;
  final double? borderRadius;
  final double? borderWidth;
  final double? elevation;

  const ElevatedAvatar({
    required this.imageUrl,
    required this.size,
    this.fit = BoxFit.contain,
    this.imageBlurHash,
    this.borderWidth,
    this.elevation,
    this.borderRadius,
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
