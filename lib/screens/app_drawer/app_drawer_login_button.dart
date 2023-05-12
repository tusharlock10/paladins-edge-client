import "package:flutter/material.dart";

class AppDrawerLoginButton extends StatelessWidget {
  final BuildContext context;
  final void Function() onPressed;

  const AppDrawerLoginButton({
    Key? key,
    required this.context,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            Icons.arrow_back,
            color: theme.colorScheme.secondary,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            "Back to Login",
            style: theme.textTheme.displaySmall?.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
