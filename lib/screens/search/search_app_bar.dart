import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;

class SearchAppBar extends HookConsumerWidget {
  final bool isLoading;
  final void Function(String) onSearch;

  const SearchAppBar({
    required this.isLoading,
    required this.onSearch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final searchProvider = ref.read(providers.players);

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final textController = useTextEditingController();
    final textStyle = textTheme.headline6?.copyWith(
      color: Colors.white,
      fontSize: 16,
    );

    // Methods
    final onClear = useCallback(
      () {
        searchProvider.clearSearchList();
        textController.clear();
      },
      [],
    );

    return SliverAppBar(
      snap: true,
      floating: true,
      forceElevated: true,
      pinned: constants.isWeb,
      title: TextField(
        controller: textController,
        maxLength: 30,
        style: textStyle,
        onSubmitted: isLoading ? null : onSearch,
        decoration: InputDecoration(
          hintText: "Search player",
          counterText: "",
          hintStyle: textStyle,
          border: InputBorder.none,
        ),
      ),
      actions: [
        Row(
          children: [
            IconButton(
              icon: isLoading
                  ? const SpinKitRing(
                      lineWidth: 2,
                      color: Colors.white,
                      size: 20,
                    )
                  : const Icon(Icons.search),
              onPressed: isLoading ? null : () => onSearch(textController.text),
            ),
            IconButton(
              iconSize: 18,
              icon: const Icon(Icons.clear),
              onPressed: onClear,
            ),
            const SizedBox(width: 10),
          ],
        ),
      ],
    );
  }
}
