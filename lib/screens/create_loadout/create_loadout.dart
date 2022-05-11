import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/create_loadout/create_loadout_delete_button.dart';
import 'package:paladinsedge/screens/create_loadout/create_loadout_draggable_cards.dart';
import 'package:paladinsedge/screens/create_loadout/create_loadout_target.dart';
import 'package:paladinsedge/screens/create_loadout/create_loadout_text.dart';
import 'package:paladinsedge/screens/index.dart' as screens;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class CreateLoadout extends HookConsumerWidget {
  static const routeName = 'createLoadout';
  static const routePath = 'createLoadout';
  static final goRoute = GoRoute(
    name: routeName,
    path: routePath,
    builder: _routeBuilder,
    redirect: utilities.Navigation.protectedRouteRedirect,
  );
  final int championId;

  const CreateLoadout({
    required this.championId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final loadoutProvider = ref.read(providers.loadout);
    final championsProvider = ref.read(providers.champions);
    final draftLoadout = ref.watch(
      providers.loadout.select((_) => _.draftLoadout),
    );
    final playerId = ref.watch(
      providers.auth.select((_) => _.player?.playerId),
    );
    final isSavingLoadout = ref.watch(
      providers.loadout.select((_) => _.isSavingLoadout),
    );

    // Variables
    final champion = championsProvider.findChampion(championId);

    // Effects
    useEffect(
      () {
        return loadoutProvider.resetDraftLoadout;
      },
      [playerId],
    );

    // Methods
    final onSave = useCallback(
      () async {
        final canSave = loadoutProvider.validateLoadout();
        if (canSave.result) {
          final success = await loadoutProvider.saveLoadout();
          if (success) {
            utilities.Navigation.pop(context);
          } else {
            widgets.showToast(
              context: context,
              text: 'An error occurred while saving loadout',
              type: widgets.ToastType.error,
            );
          }
        } else {
          widgets.showToast(
            context: context,
            text: canSave.error,
            type: widgets.ToastType.error,
          );
        }
      },
      [],
    );

    final onDelete = useCallback(
      () {
        if (draftLoadout.loadoutHash != null) {
          loadoutProvider.deleteLoadout(draftLoadout.loadoutHash!);
          utilities.Navigation.pop(context);
        }
      },
      [],
    );

    return champion == null
        ? const screens.NotFound()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                draftLoadout.loadoutHash == null
                    ? "Edit Loadout"
                    : "Create Loadout",
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: isSavingLoadout ? null : onSave,
                    child: Center(
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isSavingLoadout
                                ? const widgets.LoadingIndicator(
                                    size: 16,
                                    lineWidth: 1.5,
                                    color: Colors.white,
                                  )
                                : const SizedBox(),
                            isSavingLoadout
                                ? const SizedBox(width: 10)
                                : const SizedBox(),
                            Text(
                              isSavingLoadout ? 'Saving' : 'Save',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(height: 20),
                    CreateLoadoutTarget(champion: champion),
                    const SizedBox(height: 30),
                    const CreateLoadoutText(),
                    const SizedBox(height: 30),
                    CreateLoadoutDraggableCards(champion: champion),
                    const SizedBox(height: 30),
                    if (draftLoadout.loadoutHash != null)
                      CreateLoadoutDeleteButton(
                        onDelete: onDelete,
                      ),
                  ],
                ),
              ),
            ),
          );
  }

  static Widget _routeBuilder(_, GoRouterState state) {
    final paramChampionId = state.params['championId'];
    if (paramChampionId == null) return const screens.NotFound();
    final championId = int.tryParse(paramChampionId);
    if (championId == null) return const screens.NotFound();

    return CreateLoadout(championId: championId);
  }
}
