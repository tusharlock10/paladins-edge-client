import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;
  final double? lineWidth;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  LoadingIndicator({
    required this.size,
    this.color,
    this.lineWidth,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin,
      padding: this.padding,
      child: SpinKitRing(
        lineWidth: this.lineWidth ?? 3,
        color: this.color ?? Theme.of(context).colorScheme.secondary,
        size: this.size,
      ),
    );
  }
}
