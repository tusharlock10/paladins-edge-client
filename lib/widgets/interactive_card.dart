import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/theme/index.dart" as theme;

class InteractiveCard extends HookConsumerWidget {
  final Widget child;
  final void Function()? onTap;
  final EdgeInsets? margin;
  final EdgeInsets padding;
  final double? borderRadius;
  final bool disableHover;
  final Color? hoverBorderColor;
  final String? backgroundImage;
  final bool isAssetImage;
  final bool isOutline;
  final double hoverBorderWidth;
  final void Function(bool)? onHoverChange;
  final Color? color;
  final double? elevation;
  final double? hoverElevation;

  const InteractiveCard({
    required this.child,
    this.onTap,
    this.margin,
    this.padding = EdgeInsets.zero,
    this.borderRadius,
    this.disableHover = false,
    this.hoverBorderColor,
    this.backgroundImage,
    this.isAssetImage = false,
    this.isOutline = false,
    this.hoverBorderWidth = 2,
    this.onHoverChange,
    this.color,
    this.elevation,
    this.hoverElevation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final showChampionSplashImage = ref.read(
      providers.appState.select((_) => _.settings.showChampionSplashImage),
    );

    // Variables
    final brightness = Theme.of(context).brightness;
    final isInteractive = onTap != null && !disableHover;
    Color? internalColor = color;
    double? internalElevation = elevation;
    double? internalHoverElevation = hoverElevation;

    if (isOutline) {
      internalElevation = 0;
      internalHoverElevation = 0;
      internalColor = Colors.transparent;
    }

    // State
    final isHovering = useState<bool>(false);

    // Hooks
    final themeHoverBorderColor = useMemoized(
      () {
        return hoverBorderColor ??
            (brightness == Brightness.light
                ? theme.subtleLightThemeColor
                : theme.subtleDarkThemeColor);
      },
      [brightness, hoverBorderColor],
    );

    final colorFilter = useMemoized(
      () => ColorFilter.mode(
        Color.fromRGBO(
          255,
          255,
          255,
          brightness == Brightness.light ? 0.145 : 0.225,
        ),
        BlendMode.modulate,
      ),
      [brightness],
    );

    // Methods
    final onHover = useCallback(
      (bool value) {
        if (!isInteractive) return null;
        if (onHoverChange != null) onHoverChange!(value);
        isHovering.value = value;
      },
      [isInteractive, isHovering, onHoverChange],
    );

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: internalColor,
      elevation: isInteractive && isHovering.value
          ? internalHoverElevation
          : internalElevation,
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius == null
            ? BorderRadius.zero
            : BorderRadius.all(Radius.circular(borderRadius!)),
        side: isInteractive && isHovering.value
            ? BorderSide(
                color: themeHoverBorderColor,
                width: hoverBorderWidth,
              )
            : BorderSide.none,
      ),
      child: InkWell(
        onHover: onHover,
        hoverColor: disableHover ? Colors.transparent : null,
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: backgroundImage != null && showChampionSplashImage
                ? DecorationImage(
                    image: (isAssetImage
                            ? AssetImage(backgroundImage!)
                            : CachedNetworkImageProvider(backgroundImage!))
                        as ImageProvider,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    colorFilter: colorFilter,
                  )
                : null,
          ),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
