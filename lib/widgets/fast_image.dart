import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_blurhash/flutter_blurhash.dart";

class FastImage extends StatelessWidget {
  final String imageUrl;
  final String? imageBlurHash;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final BoxFit fit;
  final bool greyedOut;
  final Alignment? alignment;
  final String? semanticText;
  final bool isAssetImage;

  const FastImage({
    required this.imageUrl,
    this.imageBlurHash,
    this.height,
    this.width,
    this.borderRadius = BorderRadius.zero,
    this.fit = BoxFit.contain,
    this.greyedOut = false,
    this.alignment,
    this.semanticText,
    this.isAssetImage = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final canShowImageBlurHash =
        imageBlurHash != null && imageBlurHash!.length > 5;

    final image = isAssetImage
        ? Image.asset(
            imageUrl,
            height: height,
            width: width,
            fit: fit,
          )
        : CachedNetworkImage(
            placeholderFadeInDuration: const Duration(milliseconds: 250),
            fadeInDuration: Duration.zero,
            fadeOutDuration: Duration.zero,
            alignment: alignment ?? Alignment.center,
            errorWidget: (_, __, ___) => canShowImageBlurHash
                ? SizedBox(
                    height: height,
                    width: width,
                    child: BlurHash(
                      hash: imageBlurHash!,
                      image: imageUrl,
                      imageFit: fit,
                    ),
                  )
                : SizedBox(
                    height: height,
                    width: width,
                  ),
            placeholder: canShowImageBlurHash
                ? (_, __) => SizedBox(
                      height: height,
                      width: width,
                      child: BlurHash(
                        hash: imageBlurHash!,
                        image: imageUrl,
                        imageFit: fit,
                      ),
                    )
                : null,
            imageUrl: imageUrl,
            height: height,
            width: width,
            fit: fit,
          );

    return Semantics(
      readOnly: true,
      label: semanticText,
      image: true,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: greyedOut
            ? ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Colors.grey,
                  BlendMode.saturation,
                ),
                child: image,
              )
            : image,
      ),
    );
  }
}
