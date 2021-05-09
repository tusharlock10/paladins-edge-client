import 'package:flutter/material.dart';

import 'index.dart' as Widgets;

class ShadowAvatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  final double? borderRadius;
  final double? borderWidth;
  final double? elevation;

  ShadowAvatar({
    required this.imageUrl,
    required this.size,
    this.borderWidth,
    this.elevation,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.size * 2,
      width: this.size * 2,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius:
              BorderRadius.circular(this.borderRadius ?? this.size / 2),
          border: Border.all(
            color: Theme.of(context).scaffoldBackgroundColor,
            width: this.borderWidth ?? 0,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.25),
              blurRadius: this.elevation ?? 5,
              offset: Offset(0, this.elevation ?? 5),
            )
          ]),
      child: Widgets.FastImage(
        imageUrl: this.imageUrl,
        borderRadius: BorderRadius.circular(this.borderRadius ?? this.size / 2),
      ),
    );
  }
}
