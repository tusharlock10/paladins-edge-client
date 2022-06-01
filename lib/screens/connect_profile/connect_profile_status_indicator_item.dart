import "package:flutter/material.dart";

class ConnectProfileStatusIndicatorItem extends StatelessWidget {
  final int currentStep;
  final int step;
  final String label;

  const ConnectProfileStatusIndicatorItem({
    required this.currentStep,
    required this.step,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    const radius = 14.0;
    final theme = Theme.of(context);
    final isActive = currentStep == step;

    return Column(children: [
      Container(
        height: radius * 2,
        width: radius * 2,
        decoration: BoxDecoration(
          color:
              isActive ? theme.textTheme.headline1?.color : Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: Text(
            "${step + 1}",
            style: TextStyle(
              color: isActive
                  ? theme.scaffoldBackgroundColor
                  : theme.textTheme.headline1?.color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      const SizedBox(height: 15),
      Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
    ]);
  }
}
