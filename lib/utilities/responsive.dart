import "package:flutter/material.dart";
import "package:responsive_framework/responsive_framework.dart";

T responsiveCondition<T>(
  BuildContext context, {
  required T desktop,
  required T tablet,
  required T mobile,
}) {
  if (ResponsiveBreakpoints.of(context).largerThan(TABLET)) {
    return desktop;
  }
  if (ResponsiveBreakpoints.of(context).largerThan(MOBILE)) {
    return tablet;
  }

  return mobile;
}
