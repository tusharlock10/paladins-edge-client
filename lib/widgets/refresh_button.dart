import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:paladinsedge/utilities/index.dart" as utilities;

class RefreshButton extends StatelessWidget {
  final Color color;
  final RefreshCallback onRefresh;
  final bool isRefreshing;
  final EdgeInsets margin;

  const RefreshButton({
    required this.color,
    required this.onRefresh,
    required this.isRefreshing,
    this.margin = EdgeInsets.zero,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final enabled = utilities.responsiveCondition(
      context,
      desktop: true,
      tablet: true,
      mobile: false,
    );

    return enabled
        ? Padding(
            padding: margin,
            child: SizedBox(
              width: 38,
              height: 38,
              child: InkWell(
                onTap: isRefreshing ? null : onRefresh,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: color),
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: isRefreshing
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
            ),
          )
        : const SizedBox();
  }
}
