import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChampionsSearchBar extends HookWidget {
  final void Function(String) onChanged;
  final void Function() onPressed;

  const ChampionsSearchBar({
    required this.onChanged,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textController = useTextEditingController();
    final textStyle = Theme.of(context).textTheme.headline6?.copyWith(
          color: Colors.white,
          fontSize: 16,
        );

    // Methods
    final onClear = useCallback(
      () {
        textController.clear();
        onPressed();
      },
      [],
    );

    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Theme.of(context).brightness,
      ),
      title: TextField(
        controller: textController,
        maxLength: 16,
        enableInteractiveSelection: true,
        style: textStyle,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search champion',
          counterText: "",
          hintStyle: textStyle,
          border: InputBorder.none,
          suffixIcon: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.clear),
            onPressed: onClear,
          ),
        ),
      ),
    );
  }
}
