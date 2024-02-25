import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/pop_shortcut.dart";

void showSettingsModal(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final width = utilities.responsiveCondition(
    context,
    desktop: screenWidth / 2.5,
    tablet: screenWidth / 1.5,
    mobile: screenWidth,
  );

  showModalBottomSheet(
    elevation: 10,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    context: context,
    builder: (_) => _SettingsModal(),
    constraints: BoxConstraints(minWidth: width, maxWidth: width),
  );
}

class _SettingsModal extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final appStateProvider = ref.read(providers.appState);
    final settings = ref.watch(
      providers.appState.select((_) => _.settings),
    );

    // Variables
    final textTheme = Theme.of(context).textTheme;

    // Methods
    final setSelectedBottomTabIndex = useCallback(
      () {
        final nextIndex = settings.cycleBottomTabIndex();
        final newSettings = settings.copyWith(
          selectedBottomTabIndex: nextIndex,
        );
        appStateProvider.setSettings(newSettings);
      },
      [settings],
    );

    return PopShortcut(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 15,
              ),
              child: Text(
                "Settings",
                style: textTheme.titleLarge,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: setSelectedBottomTabIndex,
                      title: const Text("Change default entry tab"),
                      trailing: Text(settings.selectedBottomTabData.title),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
