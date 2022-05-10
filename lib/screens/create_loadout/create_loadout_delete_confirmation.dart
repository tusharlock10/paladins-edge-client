import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

void showCreateLoadoutDeleteConfirmation({
  required BuildContext context,
  required void Function() onDelete,
}) {
  final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
  final screenWidth = MediaQuery.of(context).size.width;
  final width = utilities.responsiveCondition(
    context,
    desktop: screenWidth / 2.5,
    tablet: screenWidth / 1.5,
    mobile: screenWidth,
  );

  showModalBottomSheet(
    elevation: 10,
    backgroundColor: backgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    context: context,
    builder: (_) => _CreateLoadoutDeleteConfirmation(onDelete: onDelete),
    constraints: BoxConstraints(maxWidth: width),
  );
}

class _CreateLoadoutDeleteConfirmation extends HookWidget {
  final void Function() onDelete;
  const _CreateLoadoutDeleteConfirmation({
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;

    // Methods
    final onDeleteConfirm = useCallback(
      () {
        utilities.Navigation.pop(context);
        onDelete();
      },
      [],
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          elevation: 0,
          clipBehavior: Clip.hardEdge,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      'DELETE LOADOUT',
                      style: textTheme.headline1?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Are you sure, you want to delete this loadout?',
                  style: textTheme.bodyText1?.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            widgets.Button(
              label: 'Cancel',
              onPressed: () => utilities.Navigation.pop(context),
              color: Colors.red,
              style: widgets.ButtonStyle.outlined,
            ),
            widgets.Button(
              label: 'Confirm',
              onPressed: onDeleteConfirm,
              color: Colors.green,
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
