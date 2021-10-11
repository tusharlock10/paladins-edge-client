import 'package:flutter/material.dart';

import 'index.dart' as Widgets;

class ElevatedAvatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  final double? borderRadius;
  final double? borderWidth;
  final double? elevation;

  ElevatedAvatar({
    required this.imageUrl,
    required this.size,
    this.borderWidth,
    this.elevation,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? this.size / 2;
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: this.elevation ?? 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        height: this.size * 2,
        width: this.size * 2,
        child: Widgets.FastImage(
          imageUrl: this.imageUrl,
        ),
      ),
    );
  }
}
