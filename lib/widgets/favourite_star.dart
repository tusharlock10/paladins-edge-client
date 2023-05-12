import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";

class FavouriteStar extends HookWidget {
  final bool isFavourite;
  final void Function()? onPress;
  final double size;
  final bool hidden;

  const FavouriteStar({
    required this.isFavourite,
    this.size = 24,
    this.hidden = false,
    this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;

    if (hidden) return const SizedBox();

    return InkWell(
      enableFeedback: onPress != null,
      onTap: onPress,
      child: Icon(
        isFavourite ? Icons.star : Icons.star_outline_outlined,
        color: isFavourite ? Colors.yellow : textTheme.bodyLarge?.color,
        size: size,
      ),
    );
  }
}
