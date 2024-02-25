import "package:flutter/material.dart";
import "package:substring_highlight/substring_highlight.dart";

class TextChip extends StatelessWidget {
  final String text;
  final double textSize;
  final MaterialColor color;
  final double spacing;
  final IconData? icon;
  final IconData? trailingIcon;
  final double iconSize;
  final double trailingIconSize;
  final double? width;
  final double? height;
  final String? highlightText;
  final void Function()? onTap;

  const TextChip({
    required this.text,
    this.icon,
    this.width,
    this.height,
    this.onTap,
    this.textSize = 9,
    this.color = Colors.grey,
    this.spacing = 0,
    this.trailingIcon,
    this.iconSize = 10,
    this.trailingIconSize = 10,
    this.highlightText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textStyle = Theme.of(context).textTheme.displayMedium;
    final color1 = isLightTheme ? color.shade50 : color.shade700;
    final color2 = isLightTheme ? color.shade900 : color.shade50;
    final color3 = color2.withOpacity(0.25);

    return SizedBox(
      width: width,
      height: height,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.symmetric(
          horizontal: spacing / 2,
          vertical: spacing / 2,
        ),
        color: color1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Icon(
                      icon,
                      color: color2,
                      size: iconSize,
                    ),
                  ),
                highlightText != null && textStyle != null
                    ? SubstringHighlight(
                        text: text,
                        term: highlightText,
                        textStyle: textStyle.copyWith(
                          fontSize: textSize,
                          color: color2,
                          fontWeight: FontWeight.normal,
                        ),
                        textStyleHighlight: textStyle.copyWith(
                          fontSize: textSize,
                          color: color2,
                          fontWeight: FontWeight.normal,
                          backgroundColor: color3,
                        ),
                      )
                    : Text(
                        text,
                        style: textStyle?.copyWith(
                          fontSize: textSize,
                          color: color2,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                if (trailingIcon != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Icon(
                      trailingIcon,
                      color: color2,
                      size: trailingIconSize,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
