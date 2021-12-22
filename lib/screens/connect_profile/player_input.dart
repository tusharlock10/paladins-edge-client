import 'package:flutter/material.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class PlayerInput extends StatelessWidget {
  final textController = TextEditingController();
  final bool isLoading;
  final void Function(String) onSearch;

  PlayerInput({
    required this.isLoading,
    required this.onSearch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      onSubmitted: onSearch,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          visualDensity: VisualDensity.compact,
          padding: const EdgeInsets.all(4),
          icon: isLoading
              ? widgets.LoadingIndicator(
                  lineWidth: 2,
                  size: 18,
                  color: Theme.of(context).primaryColor,
                )
              : const Icon(Icons.search),
          color: Theme.of(context).primaryColor,
          iconSize: 24,
          splashRadius: 24,
          onPressed: isLoading ? null : () => onSearch(textController.text),
        ),
        labelText: 'Player Name',
        hintText: 'Enter your paladins name...',
      ),
    );
  }
}
