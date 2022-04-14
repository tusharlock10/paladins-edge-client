import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginDrawerButton extends StatelessWidget {
  final BuildContext context;
  final void Function() onPressed;

  const LoginDrawerButton({
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
            FontAwesomeIcons.angleLeft,
            color: theme.colorScheme.secondary,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            'Back to Login',
            style: theme.textTheme.headline3?.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
