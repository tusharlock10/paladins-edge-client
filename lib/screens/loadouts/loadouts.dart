import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/loadouts/loadout.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class Loadouts extends HookConsumerWidget {
  static const routeName = '/loadouts';
  const Loadouts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final championsProvider = ref.read(providers.champions);
    final authProvider = ref.read(providers.auth);

    // Variables
    final textTheme = Theme.of(context).textTheme;
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;

    // State
    final isLoading = useState(true);

    // Effects
    useEffect(
      () {
        if (authProvider.player?.playerId != null) {
          isLoading.value = true;
          championsProvider
              .getPlayerLoadouts(
                authProvider.player!.playerId,
                champion.championId,
              )
              .then((_) => isLoading.value = false);
        }

        return championsProvider.resetPlayerLoadouts;
      },
      [],
    );

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text('Loadouts'),
            Text(
              champion.name,
              style: textTheme.bodyText1?.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
      body: isLoading.value
          ? const widgets.LoadingIndicator(
              size: 36,
            )
          : championsProvider.loadouts != null
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: championsProvider.loadouts!.length,
                  itemBuilder: (_, index) {
                    final loadout = championsProvider.loadouts![index];

                    return Loadout(
                      loadout: loadout,
                      champion: champion,
                    );
                  },
                )
              : const Text('Unable to fetch loadouts'),
    );
  }
}
