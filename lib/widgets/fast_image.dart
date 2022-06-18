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
  final bool? greyedOut;
  final Alignment? alignment;

  const FastImage({
    required this.imageUrl,
    this.imageBlurHash,
    this.height,
    this.width,
    this.borderRadius = BorderRadius.zero,
    this.fit = BoxFit.contain,
    this.greyedOut,
    this.alignment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = CachedNetworkImage(
      placeholderFadeInDuration: const Duration(milliseconds: 250),
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      alignment: alignment ?? Alignment.center,
      errorWidget: (_, __, ___) => imageBlurHash != null
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
      placeholder: imageBlurHash != null
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

    return ClipRRect(
      borderRadius: borderRadius,
      child: (greyedOut ?? false)
          ? ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.grey,
                BlendMode.saturation,
              ),
              child: image,
            )
          : image,
    );
  }
}
