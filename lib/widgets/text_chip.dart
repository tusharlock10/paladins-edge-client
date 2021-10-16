import 'package:flutter/material.dart';

class TextChip extends StatelessWidget {
  final String? text;
  final MaterialColor? color;
  final bool? hidden;
  final double? spacing;
  final IconData? icon;

  const TextChip({
    this.text,
    this.color = Colors.grey,
    this.spacing = 0,
    this.hidden = false,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (hidden! || text == null) {
      return const SizedBox();
    }

    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final color1 = isLightTheme ? color!.shade50 : color!.shade700;
    final color2 = isLightTheme ? color!.shade900 : color!.shade50;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: spacing! / 2, vertical: spacing! / 2),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color1,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: Icon(
                    icon,
                    color: color2,
                    size: 12,
                  ),
                )
              : const SizedBox(),
          Text(
            text!,
            style: Theme.of(context).textTheme.headline2?.copyWith(
                  fontSize: 10,
                  color: color2,
                  fontWeight: FontWeight.normal,
                ),
          ),
        ],
      ),
    );
  }
}
