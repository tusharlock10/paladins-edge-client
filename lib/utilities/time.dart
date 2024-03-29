import "package:duration/duration.dart";
import "package:jiffy/jiffy.dart";

/// Gets the time remaining between [fromDate] and [toDate] i.e.
/// toDate-fromDate in appropriately formatted string

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

  final endTime = Jiffy.parseFromMap(
    {
      Unit.second: diff.inSeconds.remainder(60),
      Unit.minute: diff.inMinutes.remainder(60),
      Unit.hour: diff.inHours,
    },
  ).format(pattern: _getFormat(diff));

  return endTime;
}

String _getFormat(Duration diff) {
  if (diff.inHours != 0) return "H[h] m[m]";
  if (diff.inMinutes != 0) return "m[m] s[s]";

  return "s[s]";
}

String getLastPlayedTime(
  DateTime lastPlayed, {
  bool shortFormat = false,
}) {
  // if difference in lastPlayed and now is greater than 1 day,
  // show the full date
  // else from the from now duration
  var lastPlayedTime = "";
  final duration = DateTime.now().difference(lastPlayed);
  lastPlayedTime =
      const Duration(days: 1).compareTo(duration) < 0 || shortFormat
          ? Jiffy.parseFromDateTime(lastPlayed).fromNow()
          : Jiffy.parseFromDateTime(lastPlayed)
              .format(pattern: "do MMM [at] HH:mm");

  return lastPlayedTime;
}

Duration forceUpdateRemainingDuration({
  required DateTime? lastUpdated,
  required int forceUpdateDuration,
}) {
  if (lastUpdated == null) return Duration.zero;
  final duration = Duration(milliseconds: forceUpdateDuration);
  final difference = lastUpdated.add(duration).difference(
        DateTime.now().toUtc(),
      );

  if (difference.isNegative) return Duration.zero;

  if (difference < duration) {
    return duration - difference;
  }

  return Duration.zero;
}

String getFormattedPlayTime(int minutes) {
  final playTime = Duration(minutes: minutes);
  DurationTersity upperTersity = DurationTersity.hour;
  DurationTersity tersity = DurationTersity.minute;

  if (playTime > const Duration(days: 1)) {
    upperTersity = DurationTersity.hour;
    tersity = DurationTersity.hour;
  }

  return printDuration(
    playTime,
    abbreviated: true,
    upperTersity: upperTersity,
    tersity: tersity,
    conjugation: " ",
  );
}
