import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;

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
  final String? backgroundImage;
  final bool isAssetImage;

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
    this.backgroundImage,
    this.isAssetImage = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final brightness = Theme.of(context).brightness;
    final isInteractive = onTap != null && !disableHover;
    final showBackgroundSplash = utilities.RemoteConfig.showBackgroundSplash;

    // State
    final isHovering = useState<bool>(false);

    // Hooks
    final themeHoverBorderColor = useMemoized(
      () {
        return hoverBorderColor ??
            (brightness == Brightness.light
                ? theme.themeMaterialColor
                : theme.themeMaterialColor.shade50);
      },
      [brightness, hoverBorderColor],
    );

    final onTapWithHaptic = useCallback(
      () {
        HapticFeedback.mediumImpact();
        if (onTap != null) onTap!();
      },
      [],
    );

    return MouseRegion(
      onEnter: !isInteractive ? null : (_) => isHovering.value = true,
      onExit: !isInteractive ? null : (_) => isHovering.value = false,
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: color,
        elevation:
            isInteractive && isHovering.value ? hoverElevation : elevation,
        margin: margin,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius == null
              ? BorderRadius.zero
              : BorderRadius.all(Radius.circular(borderRadius!)),
          side: isInteractive && isHovering.value
              ? BorderSide(
                  color: themeHoverBorderColor,
                  width: 3,
                )
              : BorderSide.none,
        ),
        child: InkWell(
          onTap: onTapWithHaptic,
          child: DecoratedBox(
            decoration: BoxDecoration(
              image: backgroundImage != null && showBackgroundSplash
                  ? DecorationImage(
                      image: (isAssetImage
                              ? AssetImage(backgroundImage!)
                              : CachedNetworkImageProvider(backgroundImage!))
                          as ImageProvider,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      colorFilter: ColorFilter.mode(
                        Color.fromRGBO(
                          255,
                          255,
                          255,
                          brightness == Brightness.light ? 0.145 : 0.225,
                        ),
                        BlendMode.modulate,
                      ),
                    )
                  : null,
            ),
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
