import 'dart:math';

import 'package:flutter/material.dart';

/// Round a `number` to nearest multile of 10
/// eg. 1733 has nearest multiple of 10 as 1000
/// so the result will be 2000
///
/// eg. 56221 -> 60000
/// eg. 101 -> 100
///
/// Optional `offset`, 0 by default, can be provided to offset the
/// nearest multiple of 10
///
/// eg. 1733 with offset 1 will have multiple of 10 as 100
/// so the result will be 1700
///
/// eg. 56221, offset=2 -> 56200
/// eg. 101, offset=2 -> 101
///
/// Optional `ceil` or `floor` param can be provided to ceil or floor the
/// output instead of rounding off. If both are true, ceil will be prioritized
///
/// eg. 56221, offset:2, ceil:true -> 56300
/// eg. 1733, offset:0, floor:true -> 1000
int roundToNearestTenth(
  int number, {
  int offset = 0,
  bool ceil = false,
  bool floor = false,
}) {
  final _exponent = number.toString().length - 1;
  final exponent = max(_exponent - offset, 0);
  final nearestMultiple = pow(10, exponent).toInt();

  double _result = (number / nearestMultiple); // 1733/1000 = 1.7
  int result;

  if (ceil) {
    result = _result.ceil() * nearestMultiple;
  } else if (floor) {
    result = _result.floor() * nearestMultiple;
  } else {
    result = _result.round() * nearestMultiple;
  }

  return result;
}

/// Callback that is called after Flutter is done painting a frame
/// eleminates the "markNeedsBuild" error
void postFrameCallback(void Function() callback) {
  WidgetsBinding.instance?.addPostFrameCallback((_) => callback());
}
