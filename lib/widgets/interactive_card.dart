import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:paladinsedge/theme/index.dart' as theme;

class InteractiveCard extends HookWidget {
  final Widget child;
  final void Function()? onTap;
  final double? elevation;
  final double? hoverElevation;
  final EdgeInsets? margin;
  final EdgeInsets padding;
  final double? borderRadius;
  final bool disableHover;
  final Color? color;
  final Color? hoverBorderColor;

  const InteractiveCard({
    required this.child,
    this.onTap,
    this.elevation,
    this.hoverElevation,
    this.margin,
    this.padding = EdgeInsets.zero,
    this.borderRadius,
    this.disableHover = false,
    this.color,
    this.hoverBorderColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final brightness = Theme.of(context).brightness;
    final isInteractive = onTap != null && !disableHover;

    // State
    final isHovering = useState<bool>(false);

    // Hooks
    final _hoverBorderColor = useMemoized(
      () {
        return hoverBorderColor ??
            (brightness == Brightness.light
                ? theme.themeMaterialColor
                : theme.themeMaterialColor.shade50);
      },
      [brightness, hoverBorderColor],
    );

    return MouseRegion(
      onEnter: !isInteractive ? null : (_) => isHovering.value = true,
      onExit: !isInteractive ? null : (_) => isHovering.value = false,
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: color,
        child: InkWell(
          onTap: onTap,
          hoverColor: color ?? Theme.of(context).cardTheme.color,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
        elevation:
            isInteractive && isHovering.value ? hoverElevation : elevation,
        margin: margin,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius == null
              ? BorderRadius.zero
              : BorderRadius.all(Radius.circular(borderRadius!)),
          side: isInteractive && isHovering.value
              ? BorderSide(
                  color: _hoverBorderColor,
                  width: 3,
                )
              : BorderSide.none,
        ),
      ),
    );
  }
}
