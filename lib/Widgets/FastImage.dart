import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';

class FastImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final BoxFit? fit;

  FastImage({
    required this.imageUrl,
    this.height,
    this.width,
    this.borderRadius = BorderRadius.zero,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: this.borderRadius,
      child: Image.network(
        this.imageUrl,
        height: this.height,
        width: this.width,
        fit: this.fit,
      ),
    );
  }
}
