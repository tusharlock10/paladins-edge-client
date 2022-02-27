import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/player_champions/player_champions_data_source.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class PlayerChampions extends HookConsumerWidget {
  static const routeName = '/playerChampions';

  const PlayerChampions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final playerChampions = ref.watch(
      providers.champions.select((_) => _.playerChampions),
    );
    final championsProvider = ref.read(providers.champions);

    // Variables
    final champions = championsProvider.champions;

    // State
    final _sortColumnIndex = useState(0);
    final _sortAscending = useState(true);
    final _playerChampionsDataSource =
        useState<PlyerChampionsDataSource?>(null);

    // Effects
    useEffect(
      () {
        if (playerChampions != null) {
          _playerChampionsDataSource.value = PlyerChampionsDataSource(
            champions: champions,
            playerChampions: playerChampions,
          );
        }

        return null;
      },
      [playerChampions],
    );

    // Methods
    final sortChampionsByColumn = useCallback(
      (int columnIndex, void Function(bool) sortChampion) {
        _sortColumnIndex.value = columnIndex;
        _sortAscending.value = !_sortAscending.value;
        sortChampion(_sortAscending.value);
      },
      [],
    );

    if (playerChampions == null) {
      return const Center(
        child: widgets.LoadingIndicator(
          size: 32,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Champions'),
      ),
      body: _playerChampionsDataSource.value == null
          ? const Center(
              child: widgets.LoadingIndicator(
                size: 32,
              ),
            )
          : const SizedBox(),
    );
  }
}
