import "package:flutter/material.dart";

class InteractiveText extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final TextStyle style;
  final bool isInteractive;
  final bool showUnderline;

  const InteractiveText(
    this.text, {
    required this.onTap,
    this.style = const TextStyle(),
    this.isInteractive = false,
    this.showUnderline = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: onTap == null ? MouseCursor.defer : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: onTap == null || !showUnderline
              ? style
              : style.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: style.color,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationThickness: 1.5,
                ),
        ),
      ),
    );
  }
}
