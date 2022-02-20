import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  final BuildContext context;
  final String label;
  final void Function() onPressed;
  final bool disabled;
  final String? subTitle;

  const DrawerButton({
    Key? key,
    required this.context,
    required this.label,
    required this.onPressed,
    this.disabled = false,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      onPressed: disabled ? null : onPressed,
      child: subTitle == null
          ? Text(
              label,
              style: theme.textTheme.headline3?.copyWith(
                color: disabled ? Colors.grey : theme.colorScheme.secondary,
              ),
            )
          : Column(
              children: [
                Text(
                  label,
                  style: theme.textTheme.headline3?.copyWith(
                    color: disabled ? Colors.grey : theme.colorScheme.secondary,
                  ),
                ),
                Text(
                  subTitle!,
                  style: theme.textTheme.headline3?.copyWith(
                    color: disabled ? Colors.grey : theme.colorScheme.secondary,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
    );
  }
}
