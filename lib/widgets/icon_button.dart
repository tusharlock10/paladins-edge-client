import "package:flutter/material.dart";
import "package:flutter/services.dart";

class IconButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;
  final double iconSize;
  final Color? color;

  const IconButton({
    required this.icon,
    required this.onPressed,
    required this.iconSize,
    this.color,
    Key? key,
  }) : super(key: key);

  void onPressedWithHaptic() {
    HapticFeedback.lightImpact();
    onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final size = iconSize * 1.25;

    return SizedBox(
      height: size,
      width: size,
      child: InkWell(
        onTap: onPressedWithHaptic,
        child: Icon(
          icon,
          size: iconSize,
          color: color,
        ),
      ),
    );
  }
}
