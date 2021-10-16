// utilities to perform various operations on widgets
import 'package:flutter/material.dart';

List<Widget> reverseWidgets(
    {required List<Widget> children, bool? shouldReverse}) {
  if (shouldReverse == true) return children.reversed.toList();
  return children;
}
