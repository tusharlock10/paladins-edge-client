import 'package:flutter/material.dart';
import 'package:paladinsedge/theme/index.dart' as theme;

enum ButtonStyle {
  solid,
  outlined,
}

class Button extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final bool disabled;
  final MaterialColor color;
  final ButtonStyle style;
  final IconData? leading;
  final IconData? trailing;

  const Button({
    required this.label,
    required this.onPressed,
    this.disabled = false,
    this.color = theme.themeMaterialColor,
    this.style = ButtonStyle.solid,
    this.leading,
    this.trailing,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final color1 = isLightTheme ? color.shade50 : color.shade700;
    final color2 = isLightTheme ? color.shade700 : color.shade50;
    final outlinedColor = isLightTheme ? color2 : color1;

    return style == ButtonStyle.outlined
        ? SizedBox(
            height: 36,
            width: 128,
            child: TextButton(
              style: TextButton.styleFrom(
                elevation: disabled ? 0 : null,
                shape: const StadiumBorder(),
                side: BorderSide(
                  color: outlinedColor,
                  width: 1,
                ),
              ),
              onPressed: disabled ? null : onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leading != null) ...[
                    Icon(
                      leading,
                      size: 14,
                      color: outlinedColor,
                    ),
                    const SizedBox(width: 5),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabled ? null : outlinedColor,
                    ),
                  ),
                  if (trailing != null) ...[
                    const SizedBox(width: 5),
                    Icon(
                      trailing,
                      size: 14,
                      color: outlinedColor,
                    ),
                  ],
                ],
              ),
            ),
          )
        : SizedBox(
            height: 36,
            width: 128,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: color1,
                elevation: disabled ? 0 : null,
                shape: const StadiumBorder(),
              ),
              onPressed: disabled ? null : onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leading != null) ...[
                    Icon(
                      leading,
                      size: 14,
                      color: color2,
                    ),
                    const SizedBox(width: 5),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabled ? null : color2,
                    ),
                  ),
                  if (trailing != null) ...[
                    const SizedBox(width: 5),
                    Icon(
                      trailing,
                      size: 14,
                      color: color2,
                    ),
                  ],
                ],
              ),
            ),
          );
  }
}
