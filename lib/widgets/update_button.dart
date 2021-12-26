import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:timer_builder/timer_builder.dart';

class UpdateButton extends StatelessWidget {
  final DateTime? lastUpdated;
  final void Function() onPressed;

  const UpdateButton({
    required this.lastUpdated,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(
      const Duration(seconds: 1),
      builder: (context) {
        final textTheme = Theme.of(context).textTheme;
        final remainingTime = _getTimeRemaining();

        if (lastUpdated == null ||
            utilities.Global.essentials?.forceUpdatePlayerDuration == null) {
          return const SizedBox();
        }

        if (remainingTime == null) {
          return SizedBox(
            height: 36,
            width: 128,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(const StadiumBorder()),
              ),
              onPressed: onPressed,
              child: const Text(
                'Update Now',
                style: TextStyle(fontSize: 14),
              ),
            ),
          );
        }

        return SizedBox(
          height: 36,
          width: 128,
          child: OutlinedButton(
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                const BorderSide(
                  color: Colors.grey,
                ),
              ),
              shape: MaterialStateProperty.all(const StadiumBorder()),
            ),
            onPressed: null,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Update In',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  remainingTime,
                  style: textTheme.bodyText1?.copyWith(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getFormat(Duration diff) {
    if (diff.inHours != 0) return "H:m:s";
    if (diff.inMinutes != 0) return "m[m] s[s]";

    return "s[s]";
  }

  String? _getTimeRemaining() {
    final diff = lastUpdated!
        .add(
          Duration(
            milliseconds:
                utilities.Global.essentials!.forceUpdatePlayerDuration,
          ),
        )
        .difference(DateTime.now());

    if (diff.isNegative) return null;

    final endTime = Jiffy(
      {
        "seconds": diff.inSeconds,
        "minutes": diff.inMinutes,
        "hours": diff.inHours,
      },
    ).format(_getFormat(diff));

    return endTime;
  }
}
