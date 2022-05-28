import "package:flutter/material.dart";
import "package:paladinsedge/screens/connect_profile/connect_profile_status_indicator_item.dart";

class ConnectProfileStatusIndicator extends StatelessWidget {
  final int currentStep;
  const ConnectProfileStatusIndicator({
    required this.currentStep,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConnectProfileStatusIndicatorItem(
            currentStep: currentStep,
            step: 0,
            label: "Search\nName",
          ),
          ConnectProfileStatusIndicatorItem(
            currentStep: currentStep,
            step: 1,
            label: "Create\nLoadout",
          ),
          ConnectProfileStatusIndicatorItem(
            currentStep: currentStep,
            step: 2,
            label: "Get\nStarted",
          ),
        ],
      ),
    );
  }
}
