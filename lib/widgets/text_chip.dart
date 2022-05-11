import 'package:flutter/material.dart';

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
  final void Function()? onTap;

  const TextChip({
    required this.text,
    this.icon,
    this.width,
    this.height,
    this.onTap,
    this.textSize = 10,
    this.color = Colors.grey,
    this.spacing = 0,
    this.trailingIcon,
    this.iconSize = 12,
    this.trailingIconSize = 12,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final color1 = isLightTheme ? color.shade50 : color.shade700;
    final color2 = isLightTheme ? color.shade900 : color.shade50;

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
                Text(
                  text,
                  style: Theme.of(context).textTheme.headline2?.copyWith(
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
