import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/constants.dart' as constants;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/connect_profile/create_loadout.dart';
import 'package:paladinsedge/screens/connect_profile/search_list.dart';
import 'package:paladinsedge/screens/connect_profile/status_indicator.dart';
import 'package:paladinsedge/screens/connect_profile/verified_player.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class ConnectProfile extends HookConsumerWidget {
  static const routeName = '/connectProfile';

  const ConnectProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final name = ref.watch(providers.auth.select((_) => _.user?.name));
    final authProvider = ref.read(providers.auth);
    final searchProvider = ref.read(providers.players);

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
      appBar: AppBar(
        title: const Text('Connect Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            name != null ? Text('Hi, $name') : const SizedBox(),
            const Text(
              'In order to enjoy all the features of Paladins Edge, please connect your profile',
            ),
            StatusIndicator(currentStep: step.value),
            Expanded(
              child: IndexedStack(
                index: step.value,
                children: [
                  SearchList(
                    isLoading: isLoading.value,
                    onSearch: (search) => onSearch(search, ref),
                    onTap: onTapSearchItem,
                  ),
                  CreateLoadout(
                    isVerifying: isVerifying.value,
                    otp: otp.value,
                    selectedPlayer: selectedPlayer.value,
                    onVerify: onVerify,
                    onChangeName: () => step.value--,
                  ),
                  const VerifiedPlayer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
