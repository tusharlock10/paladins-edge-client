import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/screens/loadouts/loadout.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;
import 'package:responsive_framework/responsive_framework.dart';

class Loadouts extends HookConsumerWidget {
  static const routeName = '/loadouts';
  const Loadouts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final loadoutProvider = ref.read(providers.loadout);
    final authProvider = ref.read(providers.auth);
    final loadouts = ref.watch(providers.loadout.select((_) => _.loadouts));
    final isGettingLoadouts =
        ref.watch(providers.loadout.select((_) => _.isGettingLoadouts));

    // Variables
    final primaryColor = Theme.of(context).primaryColor;
    final textTheme = Theme.of(context).textTheme;
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;
    final crossAxisCount =
        ResponsiveWrapper.of(context).isLargerThan(MOBILE) ? 2 : 1;
    final double horizontalPadding =
        ResponsiveWrapper.of(context).isLargerThan(MOBILE) ? 30 : 10;

    // State
    final hideLoadoutFab = useState(false);

    // Effects
    useEffect(
      () {
        if (authProvider.player?.playerId != null) {
          loadoutProvider.getPlayerLoadouts(
            authProvider.player!.playerId,
            champion.championId,
          );
        }

        return loadoutProvider.resetPlayerLoadouts;
      },
      [],
    );

    // Methods
    final onCreate = useCallback(
      () => Navigator.of(context).pushNamed(
        screens.CreateLoadout.routeName,
        arguments:
            data_classes.CreateLoadoutScreenArguments(champion: champion),
      ),
      [],
    );

    final onEdit = useCallback(
      (models.Loadout loadout) => Navigator.of(context).pushNamed(
        screens.CreateLoadout.routeName,
        arguments: data_classes.CreateLoadoutScreenArguments(
          champion: champion,
          loadout: loadout,
        ),
      ),
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
            onPressed: onCreate,
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
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      body: isGettingLoadouts
          ? const widgets.LoadingIndicator(
              size: 36,
              center: true,
            )
          : loadouts != null
              ? ResponsiveGridView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 20,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: loadouts.length,
                  gridDelegate: ResponsiveGridDelegate(
                    childAspectRatio: Loadout.loadoutAspectRatio,
                    crossAxisExtent: (MediaQuery.of(context).size.width -
                            horizontalPadding * 2) /
                        crossAxisCount,
                  ),
                  itemBuilder: (_, index) {
                    final loadout = loadouts[index];

                    return GestureDetector(
                      onTap: () => onEdit(loadout),
                      child: AbsorbPointer(
                        absorbing: true,
                        child: Loadout(
                          loadout: loadout,
                          champion: champion,
                        ),
                      ),
                    );
                  },
                )
              : const Text('Unable to fetch loadouts'),
    );
  }
}
