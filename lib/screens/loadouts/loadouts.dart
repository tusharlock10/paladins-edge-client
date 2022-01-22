import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
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
    final primaryColor = Theme.of(context).primaryColor;
    final textTheme = Theme.of(context).textTheme;
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;

    // State
    final isLoading = useState(true);
    final hideLoadoutFab = useState(false);

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

    // Methods
    final onCreateLoadoutPress = useCallback(
      () => Navigator.of(context)
          .pushNamed(screens.CreateLoadout.routeName, arguments: champion),
      [],
    );

    return Scaffold(
      floatingActionButton: SizedBox(
        height: 40,
        width: 90,
        child: AnimatedSlide(
          offset:
              hideLoadoutFab.value ? const Offset(0, 2) : const Offset(0, 0),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: onCreateLoadoutPress,
            elevation: 4,
            hoverElevation: 6,
            focusElevation: 8,
            backgroundColor: primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add,
                  size: 18,
                  color: Colors.white,
                ),
                const SizedBox(width: 2),
                Text(
                  'Create',
                  style: textTheme.bodyText2?.copyWith(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            isExtended: true,
          ),
        ),
      ),
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
