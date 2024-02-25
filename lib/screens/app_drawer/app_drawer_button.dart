import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class AppDrawerButton extends HookWidget {
  final String label;
  final void Function() onPressed;
  final String? subTitle;
  final IconData? icon;
  final IconData? trailingIcon;
  final bool hide;
  final bool isSubTitleFixed;

  const AppDrawerButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.subTitle,
    this.icon,
    this.trailingIcon,
    this.hide = false,
    this.isSubTitleFixed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;
    final isLightTheme = Brightness.light == Theme.of(context).brightness;
    final verticalPadding = utilities.responsiveCondition(
      context,
      desktop: 0.0,
      tablet: 0.0,
      mobile: 2.5,
    );

    // State
    final subtitleVisible = useState(false);

    return hide
        ? const SizedBox()
        : SizedBox(
            width: double.infinity,
            child: widgets.InteractiveCard(
              isOutline: true,
              padding:
                  const EdgeInsets.symmetric(vertical: 7.5, horizontal: 10),
              margin: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: verticalPadding,
              ),
              borderRadius: 10,
              onTap: onPressed,
              onHoverChange: (value) => subtitleVisible.value = value,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: textTheme.bodyLarge?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isLightTheme
                            ? theme.darkThemeMaterialColor
                            : theme.themeMaterialColor.shade50,
                      ),
                    ),
                    if (subTitle != null)
                      Visibility(
                        visible: subtitleVisible.value || isSubTitleFixed,
                        child: Text(
                          subTitle!,
                          style: textTheme.bodyLarge?.copyWith(fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
  }
}
