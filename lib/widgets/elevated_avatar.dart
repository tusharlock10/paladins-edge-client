import "package:flutter/material.dart";
import "package:paladinsedge/widgets/index.dart" as widgets;

class ElevatedAvatar extends StatelessWidget {
  final double elevation;
  final String imageUrl;
  final double size;
  final BoxFit fit;
  final bool greyedOut;
  final bool isAssetImage;
  final String? imageBlurHash;
  final double? borderRadius;
  final BorderSide? borderSide;
  final EdgeInsetsGeometry? margin;

  const ElevatedAvatar({
    required this.imageUrl,
    required this.size,
    this.fit = BoxFit.contain,
    this.greyedOut = false,
    this.elevation = 5,
    this.isAssetImage = false,
    this.imageBlurHash,
    this.borderRadius,
    this.borderSide,
    this.margin,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? size / 2;

    return SizedBox(
      height: size * 2,
      width: size * 2,
      child: Card(
        margin: margin,
        clipBehavior: Clip.antiAlias,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          side: borderSide ?? BorderSide.none,
        ),
        borderOnForeground: true,
        child: widgets.FastImage(
          imageUrl: imageUrl,
          isAssetImage: isAssetImage,
          imageBlurHash: imageBlurHash,
          fit: fit,
          greyedOut: greyedOut,
        ),
      ),
    );
  }
}
