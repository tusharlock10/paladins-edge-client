import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:paladinsedge/screens/create_loadout/create_loadout_delete_confirmation.dart";
import "package:paladinsedge/widgets/index.dart" as widgets;

class CreateLoadoutDeleteButton extends StatelessWidget {
  final void Function() onDelete;
  const CreateLoadoutDeleteButton({
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return widgets.Button(
      label: "Delete",
      color: Colors.red,
      disabled: false,
      leading: FeatherIcons.trash,
      onPressed: () => showCreateLoadoutDeleteConfirmation(
        context: context,
        onDelete: onDelete,
      ),
    );
  }
}
