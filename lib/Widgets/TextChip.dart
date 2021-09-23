import 'package:flutter/material.dart';

class TextChip extends StatelessWidget {
  final String? text;
  final MaterialColor? color;
  final bool? hidden;
  final double? spacing;
  final IconData? icon;

  TextChip({
    this.text,
    this.color = Colors.grey,
    this.spacing = 0,
    this.hidden = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (this.hidden! || this.text == null) {
      return SizedBox();
    }

    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final color1 = isLightTheme ? this.color!.shade50 : this.color!.shade700;
    final color2 = isLightTheme ? this.color!.shade900 : this.color!.shade50;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: this.spacing! / 2, vertical: this.spacing! / 2),
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color1,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          this.icon != null
              ? Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(
                    this.icon,
                    color: color2,
                    size: 12,
                  ),
                )
              : SizedBox.shrink(),
          Text(
            this.text!,
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
