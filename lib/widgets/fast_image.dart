import 'package:flutter/material.dart';

class FastImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final BoxFit? fit;

  const FastImage(
      {required this.imageUrl,
      this.height,
      this.width,
      this.borderRadius = BorderRadius.zero,
      this.fit = BoxFit.contain,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.network(
        imageUrl,
        height: height,
        width: width,
        fit: fit,
      ),
    );
  }
}
