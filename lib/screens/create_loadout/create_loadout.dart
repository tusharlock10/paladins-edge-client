import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:paladinsedge/models/index.dart' as models;
import 'package:paladinsedge/providers/index.dart' as providers;
import 'package:paladinsedge/screens/create_loadout/create_loadout_target.dart';
import 'package:paladinsedge/screens/create_loadout/draggable_cards.dart';
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
    final champion =
        ModalRoute.of(context)?.settings.arguments as models.Champion;

    // Effects
    useEffect(
      () {
        loadoutProvider.createDraftLoadout(
          championId: champion.championId,
          playerId: authProvider.player!.playerId,
        );

        return loadoutProvider.resetDraftLoadout;
      },
      [],
    );

    // Methods
    final onSave = useCallback(
      () async {
        final canSave = loadoutProvider.validateLoadout();
        if (canSave['result'] as bool) {
          await loadoutProvider.saveLoadout();
          Navigator.of(context).pop();
        } else {
          widgets.showToast(
            context: context,
            text: canSave['error'] as String,
            type: widgets.ToastType.error,
          );
        }
      },
      [],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Loadout'),
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
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          CreateLoadoutTarget(),
          DraggableCards(),
        ],
      ),
    );
  }
}
