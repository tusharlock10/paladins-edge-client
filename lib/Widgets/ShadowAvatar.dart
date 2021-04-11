import 'package:flutter/material.dart';

import 'index.dart' as Widgets;

class ShadowAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final double? borderWidth;
  final double? elevation;

  ShadowAvatar(
      {required this.imageUrl,
      required this.radius,
      this.borderWidth,
      this.elevation});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.radius * 2,
      width: this.radius * 2,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(
              color: Theme.of(context).scaffoldBackgroundColor,
              width: this.borderWidth ?? 0),
          borderRadius: BorderRadius.circular(this.radius),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF202020).withOpacity(0.25),
              blurRadius: this.elevation ?? 5,
              offset: Offset(0, this.elevation ?? 5),
            )
          ]),
      child: Widgets.FastImage(
        imageUrl: this.imageUrl,
        borderRadius: BorderRadius.circular(this.radius),
      ),
    );
  }
}
