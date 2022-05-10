import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/app_drawer/index.dart';
import 'package:paladinsedge/screens/connect_profile/connect_profile_loadout_verifier.dart';
import 'package:paladinsedge/screens/connect_profile/connect_profile_search_list.dart';
import 'package:paladinsedge/screens/connect_profile/connect_profile_status_indicator.dart';
import 'package:paladinsedge/screens/connect_profile/connect_profile_verified_player.dart';
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class ConnectProfile extends HookConsumerWidget {
  static const routeName = 'connectProfile';
  static const routePath = '/connectProfile';
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    builder: _routeBuilder,
    redirect: _playerConnectedRedirect,
  );

  const ConnectProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final name = ref.watch(providers.auth.select((_) => _.user?.name));
    final authProvider = ref.read(providers.auth);
    final searchProvider = ref.read(providers.players);

    // Variables
    final textTheme = Theme.of(context).textTheme;

    // State
    final otp = useState(
      constants.isDebug
          ? "MAIN"
          : (Random().nextInt(899999) + 100000).toString(),
    );
    final isLoading = useState(false);
    final isVerifying = useState(false);
    final step = useState(0); // at which step of the process the user is at
    final selectedPlayer =
        useState<api.LowerSearch?>(null); // the player selected in search step

    // Methods
    final onTapSearchItem = useCallback(
      (api.LowerSearch searchItem) {
        step.value++;
        selectedPlayer.value = searchItem;
      },
      [],
    );

    final onVerificationFailed = useCallback(
      (String? reason) {
        isVerifying.value = false;

        widgets.showToast(
          context: context,
          text: reason ?? 'Unable to verify',
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

    final onSearch = useCallback(
      (String playerName, WidgetRef ref) async {
        // exactMatch will always be false
        // topSearchList will be empty
        // lowerSearchList will contain all the search data
        // even for a single item

        isLoading.value = true;

        await searchProvider.searchByName(
          playerName: playerName,
          simpleResults: true,
          addInSearchHistory: false,
        );

        isLoading.value = false;
      },
      [],
    );

    // Build Widgets
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Connect Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 15),
            name != null
                ? RichText(
                    text: TextSpan(
                      style: textTheme.headline1,
                      children: [
                        const TextSpan(
                          text: 'Hi, ',
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
              'In order to enjoy all the features of Paladins Edge, please connect your profile',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            ConnectProfileStatusIndicator(currentStep: step.value),
            Expanded(
              child: IndexedStack(
                index: step.value,
                children: [
                  ConnectProfileSearchList(
                    isLoading: isLoading.value,
                    onSearch: (search) => onSearch(search, ref),
                    onTap: onTapSearchItem,
                  ),
                  CreateProfileLoadoutVerifier(
                    isVerifying: isVerifying.value,
                    otp: otp.value,
                    selectedPlayer: selectedPlayer.value,
                    onVerify: onVerify,
                    onChangeName: () => step.value--,
                  ),
                  const ConnectProfileVerifiedPlayer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static ConnectProfile _routeBuilder(_, __) => const ConnectProfile();

  static String? _playerConnectedRedirect(GoRouterState _) {
    // check if user is authenticated
    if (!utilities.Global.isAuthenticated) return screens.Login.routePath;
    // check if user is not connected to a player
    if (utilities.Global.isPlayerConnected) return screens.Main.routePath;

    return null;
  }
}
