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

  const Ripple({
    required this.child,
    required this.onTap,
    this.height,
    this.width,
    this.borderRadius = BorderRadius.zero,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.decoration,
    this.splashColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: decoration ?? BoxDecoration(borderRadius: borderRadius),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: splashColor,
            onTap: onTap,
            child: Container(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
