import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/utilities/index.dart" as utilities;

class RefreshButton extends HookWidget {
  final Color color;
  final RefreshCallback onRefresh;

  const RefreshButton({
    required this.color,
    required this.onRefresh,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final enabled = constants.isWeb &&
        utilities.responsiveCondition(
          context,
          desktop: true,
          tablet: true,
          mobile: false,
        );

    // State
    final isRefreshing = useState(false);

    // Methods
    final onPressRefresh = useCallback(
      () async {
        isRefreshing.value = true;
        await onRefresh();
        isRefreshing.value = false;
      },
      [onRefresh],
    );

    return enabled
        ? SizedBox(
            width: 38,
            height: 38,
            child: InkWell(
              onTap: isRefreshing.value ? null : onPressRefresh,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5, color: color),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                child: isRefreshing.value
                    ? SpinKitRing(
                        lineWidth: 1.5,
                        color: color,
                        size: 14,
                      )
                    : Icon(
                        Icons.replay,
                        color: color,
                        size: 18,
                      ),
              ),
            ),
          )
        : const SizedBox();
  }
}
