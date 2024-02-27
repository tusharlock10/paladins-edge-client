import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

void showConnectPlayerModal(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final width = utilities.responsiveCondition(
    context,
    desktop: size.width / 2,
    tablet: size.width / 1.25,
    mobile: size.width,
  );
  final height = utilities.responsiveCondition(
    context,
    desktop: size.height / 2.5,
    tablet: size.height / 2,
    mobile: size.height / 1.5,
  );

  showModalBottomSheet(
    elevation: 10,
    clipBehavior: Clip.hardEdge,
    isDismissible: false,
    enableDrag: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    context: context,
    builder: (_) => _ConnectPlayerModal(),
    constraints: BoxConstraints(
      minWidth: width,
      maxWidth: width,
      maxHeight: height,
      minHeight: height,
    ),
  );
}

class _ConnectPlayerSearch extends HookWidget {
  final void Function(String) onSearch;

  const _ConnectPlayerSearch({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    // Variables
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.bodyLarge?.copyWith(fontSize: 16);

    final searchBarColor = useMemoized(
      () => isLightTheme
          ? theme.subtleLightThemeColor
          : theme.subtleDarkThemeColor,
      [isLightTheme],
    );

    return TextField(
      maxLength: 16,
      enableInteractiveSelection: true,
      style: textStyle?.copyWith(color: Colors.white),
      onSubmitted: onSearch,
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        hintText: "Enter your Paladins IGN",
        counterText: "",
        hintStyle: textStyle?.copyWith(color: Colors.white70),
        fillColor: searchBarColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
    );
  }
}

class _ConnectPlayerModal extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playersProvider = ref.read(providers.players);
    final user = ref.watch(providers.auth.select((_) => _.user));

    // Variables
    final textTheme = Theme.of(context).textTheme;

    // State
    final isLoading = useState(false);

    // Methods
    final onNotFound = useCallback(
      (String playerName) {
        widgets.showToast(
          context: context,
          text: "Player $playerName not found",
          type: widgets.ToastType.info,
        );
      },
      [],
    );

    final onSearch = useCallback(
      (String playerName) async {
        // exactMatch will always be false
        // topSearchList will be empty
        // lowerSearchList will contain all the search data
        // even for a single item

        playerName = playerName.trim();
        if (playerName.isEmpty) return;

        isLoading.value = true;

        await playersProvider.searchByName(
          playerName: playerName,
          simpleResults: true,
          addInSearchHistory: false,
          onNotFound: onNotFound,
        );

        isLoading.value = false;
      },
      [],
    );

    return PopScope(
      canPop: false,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 20, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi, ${user?.name}",
                    style: textTheme.bodyLarge?.copyWith(fontSize: 18),
                  ),
                  Text(
                    "Link Paladins Edge to your profile, search your name and tap to connect",
                    style: textTheme.bodyLarge?.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
            _ConnectPlayerSearch(onSearch: onSearch),
          ],
        ),
      ),
    );
  }
}
