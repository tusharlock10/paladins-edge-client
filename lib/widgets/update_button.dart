import 'package:flutter/material.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:timer_builder/timer_builder.dart';

class UpdateButton extends StatelessWidget {
  final DateTime? lastUpdated;
  final void Function() onPressed;
  final bool isLoading;

  const UpdateButton({
    required this.lastUpdated,
    required this.onPressed,
    required this.isLoading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(
      const Duration(seconds: 1),
      builder: (context) {
        if (utilities.Global.essentials?.forceUpdatePlayerDuration == null) {
          return const SizedBox();
        }

        final textTheme = Theme.of(context).textTheme;
        final remainingTime = lastUpdated == null
            ? null
            : utilities.getTimeRemaining(
                toDate: lastUpdated!.add(
                  Duration(
                    milliseconds:
                        utilities.Global.essentials!.forceUpdatePlayerDuration,
                  ),
                ),
                fromDate: DateTime.now().toUtc(),
              );

        if (isLoading) {
          return SizedBox(
            height: 36,
            width: 128,
            child: OutlinedButton(
              onPressed: null,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.grey),
                shape: const StadiumBorder(),
              ),
              child: const widgets.LoadingIndicator(
                size: 16,
                center: true,
                lineWidth: 1.5,
                color: Colors.grey,
              ),
            ),
          );
        }

        if (remainingTime == null) {
          return SizedBox(
            height: 36,
            width: 128,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                shape: const StadiumBorder(),
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
}
