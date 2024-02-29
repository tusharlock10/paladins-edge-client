import "package:flutter/material.dart";
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/widgets/loading_indicator.dart";

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
  final double width;
  final bool isLoading;
  final Color? backgroundColor;
  final IconData? leading;
  final IconData? trailing;
  final double? elevation;
  final TextStyle? labelStyle;

  const Button({
    required this.label,
    required this.onPressed,
    this.disabled = false,
    this.color = theme.themeMaterialColor,
    this.style = ButtonStyle.solid,
    this.width = 128,
    this.isLoading = false,
    this.backgroundColor,
    this.leading,
    this.trailing,
    this.elevation,
    this.labelStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final color1 = isLightTheme ? color.shade50 : color.shade700;
    final color2 = isLightTheme ? color.shade700 : color.shade50;
    final outlinedColor = isLightTheme ? color2 : color1;
    final isDisabled = disabled || isLoading;

    return style == ButtonStyle.outlined
        ? SizedBox(
            height: 36,
            width: width,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: backgroundColor,
                elevation: isDisabled ? 0 : elevation,
                shape: const StadiumBorder(),
                side: BorderSide(
                  color: outlinedColor,
                  width: 1,
                ),
              ),
              onPressed: isDisabled ? null : onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leading != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(
                        leading,
                        size: 14,
                        color: outlinedColor,
                      ),
                    ),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDisabled ? null : outlinedColor,
                    ).merge(labelStyle),
                  ),
                  if (trailing != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Icon(
                        trailing,
                        size: 14,
                        color: isDisabled ? null : outlinedColor,
                      ),
                    ),
                ],
              ),
            ),
          )
        : SizedBox(
            height: 36,
            width: width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: color1,
                elevation: isDisabled ? 0 : elevation,
                shape: const StadiumBorder(),
              ),
              onPressed: isDisabled ? null : onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLoading)
                    const Padding(
                      padding: EdgeInsets.only(right: 7.5),
                      child: LoadingIndicator(
                        size: 14,
                        lineWidth: 1.5,
                      ),
                    ),
                  if (leading != null && !isLoading)
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(
                        leading,
                        size: 14,
                        color: color2,
                      ),
                    ),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDisabled ? null : color2,
                    ).merge(labelStyle),
                  ),
                  if (trailing != null && !isLoading)
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Icon(
                        trailing,
                        size: 14,
                        color: isDisabled ? null : color2,
                      ),
                    ),
                ],
              ),
            ),
          );
  }
}
