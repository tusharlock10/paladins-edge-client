import 'package:jiffy/jiffy.dart';

/// Gets the time remaining between [fromDate] and [toDate] i.e.
/// toDate-fromDate in aproperly formatted string
///
/// returns null if fromDate is ahead of toDate
String? getTimeRemaining({
  required DateTime toDate,
  required DateTime fromDate,
}) {
  final diff = toDate.difference(fromDate);

  if (diff.isNegative) return null;

  if (diff.inDays != 0) {
    return '${diff.inDays} day${diff.inDays == 1 ? "" : "s"}';
  }

  final endTime = Jiffy(
    {
      "seconds": diff.inSeconds.remainder(60),
      "minutes": diff.inMinutes.remainder(60),
      "hours": diff.inHours,
    },
  ).format(_getFormat(diff));

  return endTime;
}

String _getFormat(Duration diff) {
  if (diff.inHours != 0) return "H:mm:ss";
  if (diff.inMinutes != 0) return "m[m] s[s]";

  return "s[s]";
}
