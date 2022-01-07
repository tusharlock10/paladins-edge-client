import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/connect_profile/create_loadout.dart';
import 'package:paladinsedge/screens/connect_profile/search_list.dart';
import 'package:paladinsedge/screens/connect_profile/status_indicator.dart';
import 'package:paladinsedge/screens/connect_profile/verified_player.dart';

class ConnectProfile extends HookConsumerWidget {
  static const routeName = '/connectProfile';

  // generates a random otp for verification
  final String _otp = (Random().nextInt(899999) + 100000).toString();

  ConnectProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final name = ref.watch(providers.auth.select((_) => _.user?.name));
    final authProvider = ref.read(providers.auth);
    final searchProvider = ref.read(providers.players);

    // State
    final isLoading = useState(false);
    final isVerifying = useState(false);
    final step = useState(0); // at which step of the proccess the user is at
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
      () {
        isVerifying.value = false;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verification failed'),
          ),
        );
      },
      [],
    );

    final onVerify = useCallback(
      () async {
        if (selectedPlayer.value == null) return;

        isVerifying.value = true;

        final verified = await authProvider.claimPlayer(
          _otp,
          selectedPlayer.value!.playerId,
        );

        if (verified) {
          isVerifying.value = false;
          step.value++;
        } else {
          onVerificationFailed();
        }
      },
      [],
    );

    final onSearch = useCallback(
      (String playerName, WidgetRef ref) async {
        // exactMatch will always be false
        // topSearchList will be empty
        // lowerSeachList will contain all the search data
        // even for a single item

        isLoading.value = true;

        await searchProvider.searchByName(
          playerName: playerName,
          simpleResults: true,
          addInSeachHistory: false,
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
                    otp: _otp,
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
