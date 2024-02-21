import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;

class SearchAppBar extends HookConsumerWidget {
  final bool isLoading;
  final void Function(String) onSearch;
  final void Function(String) onChangeText;

  const SearchAppBar({
    required this.isLoading,
    required this.onSearch,
    required this.onChangeText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playersProvider = ref.read(providers.players);
    final appStateProvider = ref.read(providers.appState);
    final bottomTabIndex = ref.watch(
      providers.appState.select((_) => _.bottomTabIndex),
    );
    final searchTabVisited = ref.watch(
      providers.appState.select((_) => _.searchTabVisited),
    );

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.titleLarge?.copyWith(
      color: Colors.white,
      fontSize: 16,
    );

    // Hooks
    final focusNode = useFocusNode();
    final textController = useTextEditingController();

    // Effects
    useEffect(
      () {
        if (bottomTabIndex == 1 && !searchTabVisited) {
          focusNode.requestFocus();
          appStateProvider.setSearchTabVisited(true);
        }

        return null;
      },
      [bottomTabIndex],
    );

    // Methods
    final onClear = useCallback(
      () {
        playersProvider.clearSearchList();
        textController.clear();
        onChangeText("");
      },
      [textController, onChangeText],
    );

    return SliverAppBar(
      snap: true,
      floating: true,
      forceElevated: true,
      pinned: constants.isWeb,
      title: TextField(
        focusNode: focusNode,
        controller: textController,
        maxLength: 30,
        style: textStyle,
        onChanged: onChangeText,
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
