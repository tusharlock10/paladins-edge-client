import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/button.dart" as button_widget;
import "package:paladinsedge/widgets/loading_indicator.dart";
import "package:paladinsedge/widgets/pop_shortcut.dart";
import "package:paladinsedge/widgets/toast.dart";

void showSettingsModal(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final width = utilities.responsiveCondition(
    context,
    desktop: screenWidth / 2,
    tablet: screenWidth / 1.25,
    mobile: screenWidth,
  );

  showModalBottomSheet(
    elevation: 10,
    clipBehavior: Clip.hardEdge,
    isScrollControlled: true,
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

class _SettingTile extends StatelessWidget {
  final void Function() onPress;
  final String title;
  final String? subTitle;
  final String value;

  const _SettingTile({
    required this.onPress,
    required this.title,
    required this.value,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      leadingAndTrailingTextStyle:
          textTheme.displayLarge?.copyWith(fontSize: 16),
      subtitleTextStyle: textTheme.bodyLarge?.copyWith(fontSize: 12),
      horizontalTitleGap: 30,
      onTap: onPress,
      subtitle: subTitle == null ? null : Text(subTitle!),
      title: Text(title),
      trailing: Text(value),
    );
  }
}

class _SettingsModal extends HookConsumerWidget {
  String boolToString(bool value) {
    if (value) return "on";

    return "off";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final appStateProvider = ref.read(providers.appState);
    final authProvider = ref.read(providers.auth);
    final settings = ref.watch(
      providers.appState.select((_) => _.settings),
    );
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));

    // Variables
    final textTheme = Theme.of(context).textTheme;

    // State
    final isLoggingOut = useState(false);

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

    final setShowChampionSplashImage = useCallback(
      () {
        final newSettings = settings.copyWith(
          showChampionSplashImage: !settings.showChampionSplashImage,
        );
        appStateProvider.setSettings(newSettings);
      },
      [settings],
    );

    final setAutoOpenKeyboardOnSearch = useCallback(
      () {
        final newSettings = settings.copyWith(
          autoOpenKeyboardOnSearch: !settings.autoOpenKeyboardOnSearch,
        );
        appStateProvider.setSettings(newSettings);
      },
      [settings],
    );

    final setAutoOpenKeyboardOnChampions = useCallback(
      () {
        final newSettings = settings.copyWith(
          autoOpenKeyboardOnChampions: !settings.autoOpenKeyboardOnChampions,
        );
        appStateProvider.setSettings(newSettings);
      },
      [settings],
    );

    final onLogoutFail = useCallback(
      () {
        showToast(
          context: context,
          text: "Unable to logout, try again later",
          type: ToastType.error,
        );
      },
      [],
    );

    final onLogoutSuccess = useCallback(
      () {
        utilities.Navigation.pop(context);
      },
      [],
    );

    final onLogout = useCallback(
      () async {
        isLoggingOut.value = true;
        final isLoggedOut = await authProvider.logout();
        if (isLoggedOut) {
          onLogoutSuccess();
        } else {
          onLogoutFail();
        }
        isLoggingOut.value = false;
      },
      [],
    );

    return PopShortcut(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35,
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
                  _SettingTile(
                    onPress: setSelectedBottomTabIndex,
                    title: "Change entry screen",
                    subTitle: "Set a default entry screen for the app",
                    value: settings.selectedBottomTabData.title,
                  ),
                  _SettingTile(
                    onPress: setShowChampionSplashImage,
                    title: "Show champion splash art",
                    subTitle:
                        "Show champion splash art as background image at certain places",
                    value: boolToString(settings.showChampionSplashImage),
                  ),
                  _SettingTile(
                    onPress: setAutoOpenKeyboardOnSearch,
                    title: "Open keyboard on search",
                    subTitle:
                        "Auto open keyboard upon visiting search screen for the first time",
                    value: boolToString(settings.autoOpenKeyboardOnSearch),
                  ),
                  _SettingTile(
                    onPress: setAutoOpenKeyboardOnChampions,
                    title: "Open keyboard on champs",
                    subTitle:
                        "Auto open keyboard upon visiting champions screen for the first time",
                    value: boolToString(settings.autoOpenKeyboardOnChampions),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          if (!isGuest)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: isLoggingOut.value,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: const LoadingIndicator(size: 24),
                ),
                const SizedBox(width: 10),
                button_widget.Button(
                  color: Colors.red,
                  onPressed: onLogout,
                  label: "Logout",
                  trailing: FeatherIcons.logOut,
                  disabled: isLoggingOut.value,
                ),
                const SizedBox(width: 34),
              ],
            ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
