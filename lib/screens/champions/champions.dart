import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/champions/champions_list.dart';
import 'package:paladinsedge/screens/champions/champions_search_bar.dart';
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class Champions extends ConsumerStatefulWidget {
  static const routeName = '/champions';
  const Champions({Key? key}) : super(key: key);

  @override
  _ChampionsState createState() => _ChampionsState();
}

class _ChampionsState extends ConsumerState<Champions> {
  String search = '';
  bool _init = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    final championsProvider = ref.read(providers.champions);
    final authProvider = ref.read(providers.auth);
    if (_init) {
      _init = false;
      Future.wait([
        championsProvider.loadChampions(),
        championsProvider.getPlayerChampions(authProvider.player!.playerId),
      ]).then((_) {
        setState(() => _isLoading = false);
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ChampionsSearchBar(
        onChanged: (search) => setState(() => this.search = search),
        onPressed: () => setState(() => search = ''),
      ),
      Expanded(
        child: _isLoading
            ? const Center(
                child: widgets.LoadingIndicator(
                  size: 36,
                  color: theme.themeMaterialColor,
                ),
              )
            : ChampionsList(search: search),
      ),
    ]);
  }
}
