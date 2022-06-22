import "dart:math";

import "package:intl/intl.dart";

/// Round a `number` to nearest multiple of 10
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
  double exponent = number.toString().length - 1;
  exponent = max(exponent - offset, 0);
  final nearestMultiple = pow(10, exponent).toInt();

  double result = (number / nearestMultiple); // 1733/1000 = 1.7
  int intResult;

  if (ceil) {
    intResult = result.ceil() * nearestMultiple;
  } else if (floor) {
    intResult = result.floor() * nearestMultiple;
  } else {
    intResult = result.round() * nearestMultiple;
  }

  return intResult;
}

String humanizeNumber(num number) {
  return NumberFormat.compact().format(number);
}
