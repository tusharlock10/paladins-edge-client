import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final bool center;
  final Color? color;
  final double? lineWidth;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget? label;

  const LoadingIndicator({
    required this.size,
    this.color,
    this.lineWidth,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.center = false,
    this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loader = Container(
      margin: margin,
      padding: padding,
      child: Column(
        children: [
          SpinKitRing(
            lineWidth: lineWidth ?? 3,
            color: color ?? Theme.of(context).colorScheme.secondary,
            size: size,
          ),
          label != null
              ? Container(
                  child: label,
                  margin: const EdgeInsets.only(top: 5),
                )
              : const SizedBox(),
        ],
      ),
    );

    if (center) return Center(child: loader);

    return loader;
  }
}
