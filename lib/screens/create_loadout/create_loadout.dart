import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/data_classes/index.dart' as data_classes;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/create_loadout/create_loadout_delete_button.dart';
import 'package:paladinsedge/screens/create_loadout/create_loadout_draggable_cards.dart';
import 'package:paladinsedge/screens/create_loadout/create_loadout_target.dart';
import 'package:paladinsedge/screens/create_loadout/create_loadout_text.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class CreateLoadout extends HookConsumerWidget {
  static const routeName = '/createLoadout';

  const CreateLoadout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Providers
    final authProvider = ref.read(providers.auth);
    final loadoutProvider = ref.read(providers.loadout);
    final isSavingLoadout =
        ref.watch(providers.loadout.select((_) => _.isSavingLoadout));

    // Variables
    final arguments = ModalRoute.of(context)?.settings.arguments
        as data_classes.CreateLoadoutScreenArguments;
    final loadout = arguments.loadout;

    // Effects
    useEffect(
      () {
        loadoutProvider.createDraftLoadout(
          championId: arguments.champion.championId,
          playerId: authProvider.player!.playerId,
          loadout: loadout,
        );

        return loadoutProvider.resetDraftLoadout;
      },
      [],
    );

    // Methods
    final onSave = useCallback(
      () async {
        final canSave = loadoutProvider.validateLoadout();
        if (canSave.result) {
          final success = await loadoutProvider.saveLoadout();
          if (success) {
            Navigator.of(context).pop();
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
        if (loadout?.loadoutHash != null) {
          loadoutProvider.deleteLoadout(loadout!.loadoutHash!);
          Navigator.of(context).pop();
        }
      },
      [],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(loadout != null ? "Edit Loadout" : "Create Loadout"),
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
              const CreateLoadoutTarget(),
              const SizedBox(height: 30),
              const CreateLoadoutText(),
              const SizedBox(height: 30),
              const CreateLoadoutDraggableCards(),
              const SizedBox(height: 30),
              if (loadout?.loadoutHash != null)
                CreateLoadoutDeleteButton(
                  onDelete: onDelete,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
