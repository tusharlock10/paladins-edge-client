import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/index.dart' as Providers;
import '../Widgets/index.dart' as Widgets;
import './index.dart' as Screens;

class ConnectProfile extends StatefulWidget {
  static const routeName = '/connectProfile';

  @override
  _ConnectProfileState createState() => _ConnectProfileState();
}

class _ConnectProfileState extends State<ConnectProfile> {
  final _textController = TextEditingController();
  bool _isLoading = false;
  bool _isVerifying = false;
  int _step = 0; // at which step of the proccess the user is at
  String _otp = (Random().nextInt(899999) + 100000)
      .toString(); // generates a random otp for verification
  Map<String, dynamic>? _selectedPlayer; // the player selected in search step

  void onSearch(BuildContext context, String playerName) async {
    // exactMatch will always be false
    // topSearchList will be empty
    // lowerSeachList will contain all the search data
    // even for a single item

    this.setState(() => this._isLoading = true);
    final searchData = Provider.of<Providers.Search>(context, listen: false);
    await searchData.searchByName(playerName, simpleResults: true);
    this.setState(() => this._isLoading = false);
  }

  void onVerify(BuildContext context) async {
    this.setState(() => this._isVerifying = true);
    final authProvider = Provider.of<Providers.Auth>(context, listen: false);
    final verified = await authProvider.claimPlayer(
      this._otp,
      this._selectedPlayer?['playerId'],
    );
    if (verified) {
      this.setState(() {
        this._isVerifying = false;
        this._step++;
      });
    } else {
      this.onVerificationFailed(context);
    }
  }

  void onVerificationFailed(BuildContext context) {
    this.setState(() => this._isVerifying = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Verification failed'),
      ),
    );
  }

  Widget buildStatusIndicatorItem(int step, String label) {
    final isActive = this._step == step;
    const radius = 14.0;

    return Column(children: [
      Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        elevation: 3,
        child: Container(
          height: radius * 2,
          width: radius * 2,
          padding: EdgeInsets.all(5),
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
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      )
    ]);
  }

  Widget buildStatusIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          this.buildStatusIndicatorItem(0, 'Search\nName'),
          this.buildStatusIndicatorItem(1, 'Create\nLoadout'),
          this.buildStatusIndicatorItem(2, 'Get\nStarted'),
        ],
      ),
    );
  }

  Widget buildPlayerInput() {
    return TextField(
      controller: this._textController,
      onSubmitted: (playerName) => this.onSearch(context, playerName),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.all(4),
          icon: this._isLoading
              ? Widgets.LoadingIndicator(
                  lineWidth: 2,
                  size: 18,
                  color: Theme.of(context).primaryColor,
                )
              : Icon(Icons.search),
          color: Theme.of(context).primaryColor,
          iconSize: 24,
          splashRadius: 24,
          onPressed: this._isLoading
              ? null
              : () => this.onSearch(context, this._textController.text),
        ),
        labelText: 'Player Name',
        hintText: 'Enter your paladins name...',
      ),
    );
  }

  Widget buildSearchItem(
    Map<String, dynamic> searchItem,
  ) {
    final themeData = Theme.of(context);
    return ListTile(
      onTap: () => this.setState(() {
        this._step++;
        this._selectedPlayer = searchItem;
      }),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${searchItem['name']}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: themeData.primaryColor,
              fontSize: 18,
            ),
          ),
          Text(
            '${searchItem['isPrivate'] ? 'Private' : 'Public'}',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14,
            ),
          ),
        ],
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
            '${searchItem['playerId']}',
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
    final searchProvider = Provider.of<Providers.Search>(context);
    final searchList = searchProvider.lowerSearchList;
    final itemCount = searchList.length;

    return Column(
      children: [
        this.buildPlayerInput(),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 20),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return Column(children: [
                this.buildSearchItem(searchList[index]),
                Divider(),
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
                  text: '${this._selectedPlayer?['name']}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
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
                  text: '${this._otp}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Text('Click verify once you have created and saved your loadout'),
        TextButton(
          onPressed: () => this.onVerify(context),
          child: this._isVerifying
              ? Widgets.LoadingIndicator(
                  size: 18,
                  lineWidth: 2,
                )
              : Text('Verify'),
        ),
        TextButton(
          onPressed: () => this.setState(() => this._step--),
          child: Text('Change name'),
        )
      ],
    );
  }

  Widget buildVerifiedPlayer(BuildContext context) {
    final player = Provider.of<Providers.Auth>(context).player;
    final themeData = Theme.of(context);
    if (player == null) {
      return Container();
    }
    return Column(
      children: [
        Text('Congrats, Profile connected'),
        Text('Now you can enjoy all of the amazing features of paladins edge'),
        Row(
          children: [
            Widgets.ShadowAvatar(
              size: 28,
              borderRadius: 10,
              imageUrl: player.avatarUrl!,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${player.name}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: themeData.primaryColor,
                    fontSize: 18,
                  ),
                ),
                Text('${player.title}'),
              ],
            )
          ],
        ),
        TextButton(
            onPressed: () => Navigator.pushReplacementNamed(
                context, Screens.BottomTabs.routeName),
            child: Text('Continue'))
      ],
    );
  }

  Widget buildSteps(BuildContext context) {
    return Expanded(
      child: IndexedStack(index: this._step, children: [
        this.buildSearchList(),
        this.buildCreateLoadout(),
        this.buildVerifiedPlayer(context),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Providers.Auth>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text('Hi, ${authProvider.user?.name}'),
            Text(
              'In order to enjoy all the features of Paladins Edge, please connect your profile',
            ),
            this.buildStatusIndicator(),
            this.buildSteps(context),
          ],
        ),
      ),
    );
  }
}
