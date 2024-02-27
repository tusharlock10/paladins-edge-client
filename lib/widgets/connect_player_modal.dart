import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
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

class _ConnectPlayerHeader extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final user = ref.watch(providers.auth.select((_) => _.user));

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final firstName = user?.name.split(" ").first;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi, $firstName",
            style: textTheme.bodyLarge?.copyWith(fontSize: 18),
          ),
          Text(
            "Link Paladins Edge to your profile, search your name and tap to connect",
            style: textTheme.bodyLarge?.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _ConnectPlayerSearch extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playersProvider = ref.read(providers.players);
    final lowerSearchList =
        ref.watch(providers.players.select((_) => _.lowerSearchList));

    // Variables
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.bodyLarge?.copyWith(fontSize: 16);

    // State
    final isLoading = useState(false);

    // Hooks
    final textController = useTextEditingController();

    // Methods
    final searchBarColor = useMemoized(
      () => isLightTheme
          ? theme.subtleLightThemeColor
          : theme.subtleDarkThemeColor,
      [isLightTheme],
    );

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

    final onClear = useCallback(
      () {
        textController.clear();
        playersProvider.clearSearchList();
      },
      [],
    );

    final onSearch = useCallback(
      () async {
        // exactMatch will always be false
        // topSearchList will be empty
        // lowerSearchList will contain all the search data
        // even for a single item

        final playerName = textController.text.trim();
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
      [textController],
    );

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: textController,
            maxLength: 20,
            enableInteractiveSelection: true,
            style: textStyle?.copyWith(color: Colors.white),
            onSubmitted: (_) => onSearch(),
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
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: 36,
          height: 36,
          child: isLoading.value
              ? const widgets.LoadingIndicator(
                  size: 18,
                  lineWidth: 2,
                  center: true,
                )
              : IconButton(
                  iconSize: 18,
                  onPressed: () =>
                      lowerSearchList.isEmpty ? onSearch() : onClear(),
                  icon: Icon(
                    lowerSearchList.isEmpty
                        ? FeatherIcons.search
                        : FeatherIcons.x,
                  ),
                ),
        ),
      ],
    );
  }
}

class _ConnectPlayerList extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final lowerSearchList = ref.watch(
      providers.players.select((_) => _.lowerSearchList),
    );

    // Variables
    final textTheme = Theme.of(context).textTheme;

    // State
    final selectedPlayer = useState<api.LowerSearch?>(null);

    // Effects
    useEffect(
      () {
        selectedPlayer.value = null;

        return null;
      },
      [selectedPlayer, lowerSearchList],
    );

    return Expanded(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: selectedPlayer.value != null
            ? Column(
                children: [
                  ListTile(
                    onTap: () {},
                    title: Text(selectedPlayer.value!.name),
                    subtitle: Text(selectedPlayer.value!.platform),
                    trailing: Text(selectedPlayer.value!.playerId),
                    subtitleTextStyle: textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  widgets.Button(
                    label: "Link Profile",
                    onPressed: () {},
                  ),
                ],
              )
            : ListView.separated(
                itemCount: lowerSearchList.length,
                separatorBuilder: (_, __) => const Divider(
                  color: Colors.white,
                  thickness: 1,
                  height: 1,
                  indent: 10,
                ),
                itemBuilder: (_, index) {
                  final player = lowerSearchList[index];

                  return ListTile(
                    onTap: () => selectedPlayer.value = player,
                    title: Text(player.name),
                    subtitle: Text(player.platform),
                    trailing: Text(player.playerId),
                    subtitleTextStyle: textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class _ConnectPlayerModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            _ConnectPlayerHeader(),
            const SizedBox(height: 10),
            _ConnectPlayerSearch(),
            const SizedBox(height: 10),
            _ConnectPlayerList(),
          ],
        ),
      ),
    );
  }
}
