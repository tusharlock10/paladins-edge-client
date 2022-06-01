import "package:flutter/material.dart";
import "package:paladinsedge/widgets/index.dart" as widgets;

class ConnectProfilePlayerInput extends StatelessWidget {
  final textController = TextEditingController();
  final bool isLoading;
  final void Function(String) onSearch;

  ConnectProfilePlayerInput({
    required this.isLoading,
    required this.onSearch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return TextField(
      controller: textController,
      onSubmitted: onSearch,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: secondaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: secondaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: IconButton(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          icon: isLoading
              ? widgets.LoadingIndicator(
                  lineWidth: 2,
                  size: 18,
                  color: secondaryColor,
                )
              : const Icon(Icons.search),
          color: secondaryColor,
          iconSize: 24,
          splashRadius: 24,
          onPressed: isLoading ? null : () => onSearch(textController.text),
        ),
        labelText: "Player Name",
        hintText: "Enter your Paladins IGN",
        labelStyle: TextStyle(color: secondaryColor),
      ),
    );
  }
}
