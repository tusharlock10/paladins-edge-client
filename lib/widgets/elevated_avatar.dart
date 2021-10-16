import 'package:flutter/material.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class ElevatedAvatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  final double? borderRadius;
  final double? borderWidth;
  final double? elevation;

  const ElevatedAvatar(
      {required this.imageUrl,
      required this.size,
      this.borderWidth,
      this.elevation,
      this.borderRadius,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? size / 2;
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: elevation ?? 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: SizedBox(
        height: size * 2,
        width: size * 2,
        child: widgets.FastImage(
          imageUrl: imageUrl,
        ),
      ),
    );
  }
}
