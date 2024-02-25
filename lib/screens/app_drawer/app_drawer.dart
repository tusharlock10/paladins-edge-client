import "package:dartx/dartx.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/data_classes/index.dart" as data_classes;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/app_drawer/app_drawer_button.dart";
import "package:paladinsedge/screens/app_drawer/app_drawer_guest_profile.dart";
import "package:paladinsedge/screens/app_drawer/app_drawer_info.dart";
import "package:paladinsedge/screens/app_drawer/app_drawer_player_profile.dart";
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/theme/index.dart" as theme;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class AppDrawer extends HookConsumerWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final isPlatformSupported = !constants.isWindows;
    final authProvider = ref.read(providers.auth);
    final appStateProvider = ref.read(providers.appState);
    final playersProvider = ref.read(providers.players);
    final player = ref.watch(providers.auth.select((_) => _.player));
    final isGuest = ref.watch(providers.auth.select((_) => _.isGuest));
    final themeMode = ref.watch(
      providers.appState.select((_) => _.settings.themeMode),
    );

    // State
    final isLoggingOut = useState(false);

    // Hooks
    final showPlayerDependentButtons = useMemoized(
      () {
        // to show or hide buttons dependant on player info
        // this scenario happens on connect profile screen
        // if user is a guest, then show the button but ask for
        // login on the specific screen
        return player != null || isGuest;
      },
      [],
    );

    // Methods
    final navigateToLogin = useCallback(
      () {
        utilities.Navigation.pop(context);
        utilities.Navigation.navigate(context, screens.Login.routeName);
      },
      [],
    );

    final onLogoutFail = useCallback(
      () {
        widgets.showToast(
          context: context,
          text: "Unable to logout, try again later",
          type: widgets.ToastType.error,
        );
      },
      [],
    );

    final onLogout = useCallback(
      () async {
        isLoggingOut.value = true;
        final isLoggedOut = await authProvider.logout();

        if (isLoggedOut) {
          navigateToLogin();
        } else {
          onLogoutFail();
        }
        isLoggingOut.value = false;
      },
      [],
    );

    final onChangeTheme = useCallback(
      () {
        final nextThemeMode = theme.ThemeUtil.cycleThemeMode(themeMode);
        appStateProvider.toggleTheme(nextThemeMode);
      },
      [themeMode],
    );

    final themeName = useMemoized(
      () {
        return theme.ThemeUtil.getThemeName(themeMode);
      },
      [themeMode],
    );

    final nextThemeName = useMemoized(
      () {
        final nextThemeMode = theme.ThemeUtil.cycleThemeMode(themeMode);

        return theme.ThemeUtil.getThemeName(nextThemeMode);
      },
      [themeMode],
    );

    final onFriendsHelper = useCallback(
      () {
        utilities.Navigation.pop(context);
        utilities.Navigation.navigate(context, screens.Friends.userRouteName);
      },
      [],
    );

    final onFriends = useCallback(
      () {
        if (isGuest) {
          utilities.Navigation.pop(context);
          widgets.showLoginModal(
            data_classes.ShowLoginModalOptions(
              context: context,
              loginCta: constants.LoginCTA.friendsDrawer,
            ),
          );
        } else {
          onFriendsHelper();
        }
      },
      [isGuest],
    );

    final onActiveMatchHelper = useCallback(
      () {
        if (player == null) return;
        playersProvider.resetPlayerStatus();
        utilities.Navigation.pop(context);
        utilities.Navigation.navigate(
          context,
          screens.ActiveMatch.userRouteName,
        );
      },
      [player],
    );

    final onActiveMatch = useCallback(
      () {
        if (isGuest) {
          utilities.Navigation.pop(context);
          widgets.showLoginModal(
            data_classes.ShowLoginModalOptions(
              context: context,
              loginCta: constants.LoginCTA.activeMatchDrawer,
            ),
          );
        } else {
          onActiveMatchHelper();
        }
      },
      [isGuest],
    );

    final onFeedback = useCallback(
      () {
        final routeName = showPlayerDependentButtons
            ? screens.Feedback.routeName
            : screens.Feedback.connectProfileRouteName;
        utilities.Navigation.pop(context);
        utilities.Navigation.navigate(context, routeName);
      },
      [showPlayerDependentButtons],
    );

    final onGlobalChatHelper = useCallback(
      () {
        utilities.Navigation.pop(context);
        utilities.Navigation.navigate(context, screens.GlobalChat.routeName);
      },
      [],
    );

    final onGlobalChat = useCallback(
      () {
        if (isGuest) {
          utilities.Navigation.pop(context);
          widgets.showLoginModal(
            data_classes.ShowLoginModalOptions(
              context: context,
              loginCta: constants.LoginCTA.globalChat,
            ),
          );
        } else {
          onGlobalChatHelper();
        }
      },
      [isGuest],
    );

    final onSavedMatchesHelper = useCallback(
      () {
        utilities.Navigation.pop(context);
        utilities.Navigation.navigate(context, screens.SavedMatches.routeName);
      },
      [],
    );

    final onSavedMatches = useCallback(
      () {
        if (isGuest) {
          utilities.Navigation.pop(context);
          widgets.showLoginModal(
            data_classes.ShowLoginModalOptions(
              context: context,
              loginCta: constants.LoginCTA.savedMatches,
            ),
          );
        } else {
          onSavedMatchesHelper();
        }
      },
      [isGuest],
    );

    final onLeaderboard = useCallback(
      () {
        utilities.Navigation.pop(context);
        utilities.Navigation.navigate(context, screens.Leaderboard.routeName);
      },
      [],
    );

    final onSponsor = useCallback(
      () {
        utilities.Navigation.pop(context);
        utilities.Navigation.navigate(context, screens.Sponsor.routeName);
      },
      [],
    );

    final onFAQ = useCallback(
      () {
        final routeName = showPlayerDependentButtons
            ? screens.Faqs.routeName
            : screens.Faqs.connectProfileRouteName;
        utilities.Navigation.pop(context);
        utilities.Navigation.navigate(context, routeName);
      },
      [showPlayerDependentButtons],
    );

    final onSettings = useCallback(
      () {
        Scaffold.of(context).closeDrawer();
        widgets.showSettingsModal(context);
      },
      [],
    );

    return widgets.PopShortcut(
      child: SafeArea(
        child: Drawer(
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      !isGuest
                          ? const AppDrawerGuestProfile()
                          : const AppDrawerPlayerProfile(),
                      const SizedBox(height: 10),
                      Divider(color: Colors.grey.shade600, thickness: 0.15),
                      const SizedBox(height: 10),
                      AppDrawerButton(
                        label: "$themeName Theme".capitalize(),
                        subTitle: "Switch to $nextThemeName theme",
                        isSubTitleFixed: utilities.responsiveCondition(
                          context,
                          desktop: false,
                          tablet: false,
                          mobile: true,
                        ),
                        onPressed: onChangeTheme,
                      ),
                      AppDrawerButton(
                        label: "Friends",
                        subTitle: "View your friend list",
                        onPressed: onFriends,
                        hide: !showPlayerDependentButtons,
                      ),
                      AppDrawerButton(
                        label: "Active Match",
                        subTitle: "View live match details",
                        onPressed: onActiveMatch,
                        hide: !showPlayerDependentButtons,
                      ),
                      AppDrawerButton(
                        label: "Feedback",
                        subTitle: "Tell us something",
                        onPressed: onFeedback,
                      ),
                      AppDrawerButton(
                        label: "Global Chat",
                        subTitle: "Chat with everyone",
                        onPressed: onGlobalChat,
                        hide: !(showPlayerDependentButtons &&
                            isPlatformSupported),
                      ),
                      AppDrawerButton(
                        label: "Saved Matches",
                        subTitle: "View your saved matches",
                        onPressed: onSavedMatches,
                        hide: !showPlayerDependentButtons,
                      ),
                      AppDrawerButton(
                        label: "Leaderboard",
                        subTitle: "View player rankings",
                        onPressed: onLeaderboard,
                      ),
                      AppDrawerButton(
                        label: "Sponsor",
                        subTitle: "Support us",
                        onPressed: onSponsor,
                      ),
                      AppDrawerButton(
                        label: "FAQs",
                        subTitle: "Answers to common questions",
                        onPressed: onFAQ,
                      ),
                      AppDrawerButton(
                        label: "Settings",
                        subTitle: "Set your preferences",
                        onPressed: onSettings,
                      ),
                    ],
                  ),
                ),
              ),
              const AppDrawerInfo(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
