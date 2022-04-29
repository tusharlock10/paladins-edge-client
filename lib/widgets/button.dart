import 'package:flutter/material.dart';
import 'package:paladinsedge/theme/index.dart' as theme;

class Button extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final bool disabled;
  final MaterialColor? color;

  const Button({
    required this.label,
    required this.onPressed,
    this.disabled = false,
    this.color = theme.themeMaterialColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final color1 = isLightTheme ? color!.shade50 : color!.shade700;
    final color2 = isLightTheme ? color!.shade900 : color!.shade50;

    return SizedBox(
      height: 36,
      width: 128,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color1,
          elevation: disabled ? 0 : null,
          shape: const StadiumBorder(),
        ),
        onPressed: disabled ? null : onPressed,
        child: Text(
          label,
          style: TextStyle(fontSize: 14, color: disabled ? null : color2),
        ),
      ),
    );
  }
}
