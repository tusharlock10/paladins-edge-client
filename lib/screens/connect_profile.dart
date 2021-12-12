import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/api/index.dart' as api;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class ConnectProfile extends ConsumerStatefulWidget {
  static const routeName = '/connectProfile';
  const ConnectProfile({Key? key}) : super(key: key);

  @override
  _ConnectProfileState createState() => _ConnectProfileState();
}

class _ConnectProfileState extends ConsumerState<ConnectProfile> {
  final _textController = TextEditingController();
  bool _isLoading = false;
  bool _isVerifying = false;
  int _step = 0; // at which step of the proccess the user is at
  final String _otp = "MAIN" // (Random().nextInt(899999) + 100000)
      .toString(); // generates a random otp for verification
  api.LowerSearch? _selectedPlayer; // the player selected in search step

  void onSearch(BuildContext context, String playerName) async {
    // exactMatch will always be false
    // topSearchList will be empty
    // lowerSeachList will contain all the search data
    // even for a single item

    setState(() => _isLoading = true);
    final searchProvider = ref.read(providers.players);
    await searchProvider.searchByName(
      playerName,
      simpleResults: true,
      addInSeachHistory: false,
    );
    setState(() => _isLoading = false);
  }

  void onVerify(BuildContext context) async {
    if (_selectedPlayer == null) return;
    setState(() => _isVerifying = true);
    final authProvider = ref.read(providers.auth);
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
      onVerificationFailed(context);
    }
  }

  void onVerificationFailed(BuildContext context) {
    setState(() => _isVerifying = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Verification failed'),
      ),
    );
  }

  Widget buildStatusIndicatorItem(int step, String label) {
    final isActive = _step == step;
    const radius = 14.0;

    return Column(children: [
      Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        elevation: 3,
        child: Container(
          height: radius * 2,
          width: radius * 2,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: isActive ? Theme.of(context).primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Center(
            child: Text(
              '${step + 1}',
              style: TextStyle(
                color: isActive ? Colors.white : Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      )
    ]);
  }

  Widget buildStatusIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildStatusIndicatorItem(0, 'Search\nName'),
          buildStatusIndicatorItem(1, 'Create\nLoadout'),
          buildStatusIndicatorItem(2, 'Get\nStarted'),
        ],
      ),
    );
  }

  Widget buildPlayerInput() {
    return TextField(
      controller: _textController,
      onSubmitted: (playerName) => onSearch(context, playerName),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          visualDensity: VisualDensity.compact,
          padding: const EdgeInsets.all(4),
          icon: _isLoading
              ? widgets.LoadingIndicator(
                  lineWidth: 2,
                  size: 18,
                  color: Theme.of(context).primaryColor,
                )
              : const Icon(Icons.search),
          color: Theme.of(context).primaryColor,
          iconSize: 24,
          splashRadius: 24,
          onPressed:
              _isLoading ? null : () => onSearch(context, _textController.text),
        ),
        labelText: 'Player Name',
        hintText: 'Enter your paladins name...',
      ),
    );
  }

  Widget buildSearchItem(
    api.LowerSearch searchItem,
  ) {
    final themeData = Theme.of(context);
    return ListTile(
      onTap: () => setState(() {
        _step++;
        _selectedPlayer = searchItem;
      }),
      title: Text(
        searchItem.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: themeData.primaryColor,
          fontSize: 18,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Player Id',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
          Text(
            searchItem.playerId,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchList() {
    final searchProvider = ref.watch(providers.players);
    final searchList = searchProvider.lowerSearchList;
    final itemCount = searchList.length;

    return Column(
      children: [
        buildPlayerInput(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return Column(children: [
                buildSearchItem(searchList[index]),
                const Divider(),
              ]);
            },
          ),
        ),
      ],
    );
  }

  Widget buildCreateLoadout() {
    final textTheme = Theme.of(context).textTheme.headline6;
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: 'Verifying for ',
            style: TextStyle(
              color: textTheme?.color,
              fontFamily: textTheme?.fontFamily,
            ),
            children: [
              TextSpan(
                  text: '${_selectedPlayer?.name}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: 'Create a loadout with the name ',
            style: TextStyle(
              color: textTheme?.color,
              fontFamily: textTheme?.fontFamily,
            ),
            children: [
              TextSpan(
                  text: _otp,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const Text('Click verify once you have created and saved your loadout'),
        TextButton(
          onPressed: () => onVerify(context),
          child: _isVerifying
              ? const widgets.LoadingIndicator(
                  size: 18,
                  lineWidth: 2,
                )
              : const Text('Verify'),
        ),
        TextButton(
          onPressed: () => setState(() => _step--),
          child: const Text('Change name'),
        )
      ],
    );
  }

  Widget buildVerifiedPlayer(BuildContext context) {
    final player = ref.watch(providers.auth.select((_) => _.player));
    final themeData = Theme.of(context);
    if (player == null) {
      return Container();
    }
    return Column(
      children: [
        const Text('Congrats, Profile connected'),
        const Text(
            'Now you can enjoy all of the amazing features of paladins edge'),
        Row(
          children: [
            widgets.ElevatedAvatar(
              size: 28,
              borderRadius: 10,
              imageUrl: player.avatarUrl!,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  player.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: themeData.primaryColor,
                    fontSize: 18,
                  ),
                ),
                player.title != null ? Text(player.title!) : const SizedBox(),
              ],
            )
          ],
        ),
        TextButton(
            onPressed: () => Navigator.pushReplacementNamed(
                context, screens.BottomTabs.routeName),
            child: const Text('Continue'))
      ],
    );
  }

  Widget buildSteps(BuildContext context) {
    return Expanded(
      child: IndexedStack(index: _step, children: [
        buildSearchList(),
        buildCreateLoadout(),
        buildVerifiedPlayer(context),
      ]),
    );
  }

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
            buildStatusIndicator(),
            buildSteps(context),
          ],
        ),
      ),
    );
  }
}
