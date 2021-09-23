import 'package:flutter/material.dart';

class Ripple extends StatelessWidget {
  final Widget child;
  final void Function() onTap;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;
  final Color? splashColor;

  Ripple({
    required this.child,
    required this.onTap,
    this.height,
    this.width,
    this.borderRadius = BorderRadius.zero,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.decoration,
    this.splashColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      width: this.width,
      margin: this.margin,
      decoration:
          this.decoration ?? BoxDecoration(borderRadius: this.borderRadius),
      child: ClipRRect(
        borderRadius: this.borderRadius,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: this.splashColor,
            onTap: this.onTap,
            child: Container(
              padding: this.padding,
              child: this.child,
            ),
          ),
        ),
      ),
    );
  }
}
