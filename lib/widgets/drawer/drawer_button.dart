import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  final BuildContext context;
  final String label;
  final bool disabled;
  final void Function() onPressed;

  const DrawerButton({
    Key? key,
    required this.context,
    required this.label,
    required this.onPressed,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      onPressed: disabled ? null : onPressed,
      child: Text(
        label,
        style: theme.textTheme.headline3?.copyWith(
          color: disabled ? Colors.grey : theme.colorScheme.secondary,
        ),
      ),
    );
  }
}
