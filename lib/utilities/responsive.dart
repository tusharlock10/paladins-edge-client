import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

T responsiveCondition<T>(
  BuildContext context, {
  required T desktop,
  required T tablet,
  required T mobile,
}) {
  if (ResponsiveWrapper.of(context).isLargerThan(TABLET)) {
    return desktop;
  }
  if (ResponsiveWrapper.of(context).isLargerThan(MOBILE)) {
    return tablet;
  }

  return mobile;
}

unFocusNode(BuildContext context) {
  print("UNFOCUS");
  FocusScope.of(context).requestFocus(FocusNode());
}
