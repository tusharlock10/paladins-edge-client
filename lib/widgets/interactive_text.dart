import "package:flutter/material.dart";
import "package:flutter/services.dart";

class InteractiveText extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final TextStyle style;
  final bool showUnderline;

  const InteractiveText(
    this.text, {
    required this.onTap,
    this.style = const TextStyle(),
    this.showUnderline = true,
    Key? key,
  }) : super(key: key);

  void onTapWithHaptic() {
    HapticFeedback.lightImpact();
    if (onTap != null) onTap!();
  }

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      text,
      onTap: onTapWithHaptic,
      enableInteractiveSelection: onTap != null,
      maxLines: 1,
      scrollPhysics: const ClampingScrollPhysics(),
      style: onTap == null || !showUnderline
          ? style
          : style.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: style.color,
              decorationStyle: TextDecorationStyle.solid,
              decorationThickness: 1.5,
            ),
    );
  }
}
