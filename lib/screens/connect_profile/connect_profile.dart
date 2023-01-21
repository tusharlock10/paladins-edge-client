import "dart:math";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:paladinsedge/api/index.dart" as api;
import "package:paladinsedge/constants/index.dart" as constants;
import "package:paladinsedge/providers/index.dart" as providers;
import "package:paladinsedge/screens/app_drawer/index.dart";
import "package:paladinsedge/screens/connect_profile/connect_profile_loadout_verifier.dart";
import "package:paladinsedge/screens/connect_profile/connect_profile_search_list.dart";
import "package:paladinsedge/screens/connect_profile/connect_profile_status_indicator.dart";
import "package:paladinsedge/screens/connect_profile/connect_profile_verified_player.dart";
import "package:paladinsedge/screens/index.dart" as screens;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:paladinsedge/widgets/index.dart" as widgets;

class ConnectProfile extends HookConsumerWidget {
  static const routeName = "connect-profile";
  static const routePath = "/connect-profile";
  const ConnectProfile({Key? key}) : super(key: key);

  static GoRoute goRouteBuilder(List<GoRoute> routes) => GoRoute(
        name: routeName,
        path: routePath,
        routes: routes,
        pageBuilder: _routeBuilder,
        redirect: _playerConnectedRedirect,
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final authProvider = ref.read(providers.auth);
    final playersProvider = ref.read(providers.players);
    final name = ref.watch(providers.auth.select((_) => _.user?.name));

    // Variables
    final textTheme = Theme.of(context).textTheme;

    // State
    final otp = useState(
      constants.isDebug
          ? "MAIN"
          : (Random().nextInt(899999) + 100000).toString(),
    );
    final isLoading = useState(false);
    final isCheckingPlayer = useState<int?>(null);
    final isVerifying = useState(false);
    final showVerifyHelp = useState(false);
    final step = useState(0); // at which step of the process the user is at
    final selectedPlayer =
        useState<api.LowerSearch?>(null); // the player selected in search step

    // Methods
    final onTapSearchItem = useCallback(
      (api.LowerSearch searchItem) async {
        isCheckingPlayer.value = searchItem.playerId;
        final exists = await authProvider.checkPlayerClaimed(
          searchItem.playerId,
        );
        if (exists == null) {
          widgets.showToast(
            context: context,
            text: "Something went wrong",
            type: widgets.ToastType.error,
          );
        } else if (exists) {
          widgets.showToast(
            context: context,
            text: "Player is already claimed",
            type: widgets.ToastType.info,
          );
        } else {
          step.value++;
          selectedPlayer.value = searchItem;
        }

        isCheckingPlayer.value = null;
      },
      [],
    );

    final onVerificationFailed = useCallback(
      (String? reason) {
        isVerifying.value = false;
        showVerifyHelp.value = true;

        widgets.showToast(
          context: context,
          text: reason ?? "Unable to verify",
          type: widgets.ToastType.error,
        );
      },
      [],
    );

    final onVerify = useCallback(
      () async {
        if (selectedPlayer.value == null) return;

        isVerifying.value = true;

        final result = await authProvider.claimPlayer(
          otp.value,
          selectedPlayer.value!.playerId,
        );

        if (result != null && result.verified) {
          isVerifying.value = false;
          step.value++;
        } else {
          onVerificationFailed(result?.reason);
        }
      },
      [],
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

    final onSearch = useCallback(
      (String playerName, WidgetRef ref) async {
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

    // Build Widgets
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Connect Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            name != null
                ? RichText(
                    text: TextSpan(
                      style: textTheme.headline1,
                      children: [
                        const TextSpan(
                          text: "Hi, ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: name,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: 15),
            const Text(
              "In order to enjoy all the features of Paladins Edge, please connect your profile",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            ConnectProfileStatusIndicator(currentStep: step.value),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: IndexedStack(
                  index: step.value,
                  children: [
                    ConnectProfileSearchList(
                      isLoading: isLoading.value,
                      onSearch: (search) => onSearch(search, ref),
                      onTap: onTapSearchItem,
                      isCheckingPlayer: isCheckingPlayer.value,
                    ),
                    CreateProfileLoadoutVerifier(
                      isVerifying: isVerifying.value,
                      showVerifyHelp: showVerifyHelp.value,
                      otp: otp.value,
                      selectedPlayer: selectedPlayer.value,
                      onVerify: onVerify,
                      onChangeName: () => step.value--,
                    ),
                    const ConnectProfileVerifiedPlayer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Page _routeBuilder(_, __) =>
      const CupertinoPage(child: ConnectProfile());

  static String? _playerConnectedRedirect(GoRouterState _) {
    // check if user is authenticated
    if (!utilities.Global.isAuthenticated) return screens.Login.routePath;
    // check if user is not connected to a player
    if (utilities.Global.isPlayerConnected) return screens.Main.routePath;

    return null;
  }
}
