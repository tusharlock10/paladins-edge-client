import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/connect_profile/create_loadout.dart';
import 'package:paladinsedge/screens/connect_profile/search_list.dart';
import 'package:paladinsedge/screens/connect_profile/status_indicator.dart';
import 'package:paladinsedge/screens/connect_profile/verified_player.dart';

class ConnectProfile extends ConsumerStatefulWidget {
  static const routeName = '/connectProfile';
  const ConnectProfile({Key? key}) : super(key: key);

  @override
  _ConnectProfileState createState() => _ConnectProfileState();
}

class _ConnectProfileState extends ConsumerState<ConnectProfile> {
  bool _isLoading = false;
  bool _isVerifying = false;
  int _step = 0; // at which step of the proccess the user is at

  // generates a random otp for verification
  final String _otp = "MAIN"; // (Random().nextInt(899999) + 100000).toString();
  api.LowerSearch? _selectedPlayer; // the player selected in search step

  void onSearch(String playerName) async {
    // exactMatch will always be false
    // topSearchList will be empty
    // lowerSeachList will contain all the search data
    // even for a single item
    final searchProvider = ref.read(providers.players);

    setState(() => _isLoading = true);
    await searchProvider.searchByName(
      playerName: playerName,
      simpleResults: true,
      addInSeachHistory: false,
    );
    setState(() => _isLoading = false);
  }

  void onVerify() async {
    if (_selectedPlayer == null) return;

    final authProvider = ref.read(providers.auth);

    setState(() => _isVerifying = true);
    final verified = await authProvider.claimPlayer(
      _otp,
      _selectedPlayer!.playerId,
    );
    if (verified) {
      setState(() {
        _isVerifying = false;
        _step++;
      });
    } else {
      onVerificationFailed();
    }
  }

  void onChangeName() => setState(() => _step--);

  void onVerificationFailed() {
    setState(() => _isVerifying = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Verification failed'),
      ),
    );
  }

  void onTapSearchItem(api.LowerSearch searchItem) => setState(() {
        _step++;
        _selectedPlayer = searchItem;
      });

  @override
  Widget build(BuildContext context) {
    final name = ref.watch(providers.auth.select((_) => _.user?.name));
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
            StatusIndicator(currentStep: _step),
            Expanded(
              child: IndexedStack(
                index: _step,
                children: [
                  SearchList(
                    isLoading: _isLoading,
                    onSearch: onSearch,
                    onTap: onTapSearchItem,
                  ),
                  CreateLoadout(
                    isVerifying: _isVerifying,
                    otp: _otp,
                    selectedPlayer: _selectedPlayer,
                    onVerify: onVerify,
                    onChangeName: onChangeName,
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
