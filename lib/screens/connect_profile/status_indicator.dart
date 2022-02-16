import 'package:flutter/material.dart';

class _StatusIndicatorItem extends StatelessWidget {
  final int currentStep;
  final int step;
  final String label;

  const _StatusIndicatorItem({
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
            '${step + 1}',
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

class StatusIndicator extends StatelessWidget {
  final int currentStep;
  const StatusIndicator({
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
          _StatusIndicatorItem(
            currentStep: currentStep,
            step: 0,
            label: 'Search\nName',
          ),
          _StatusIndicatorItem(
            currentStep: currentStep,
            step: 1,
            label: 'Create\nLoadout',
          ),
          _StatusIndicatorItem(
            currentStep: currentStep,
            step: 2,
            label: 'Get\nStarted',
          ),
        ],
      ),
    );
  }
}
