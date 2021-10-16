import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;
  final double? lineWidth;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const LoadingIndicator(
      {required this.size,
      this.color,
      this.lineWidth,
      this.margin = EdgeInsets.zero,
      this.padding = EdgeInsets.zero,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: SpinKitRing(
        lineWidth: lineWidth ?? 3,
        color: color ?? Theme.of(context).colorScheme.secondary,
        size: size,
      ),
    );
  }
}
