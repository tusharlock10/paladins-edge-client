import "package:expandable/expandable.dart";
import "package:flutter/material.dart";
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/widgets/index.dart" as widgets;

class FaqItem extends StatelessWidget {
  final models.FAQ faq;
  const FaqItem({
    required this.faq,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final expandedController = ExpandableController(initialExpanded: false);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 7.5,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    faq.title,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: expandedController,
                  builder: (context, isExpanded, _) {
                    return AnimatedRotation(
                      duration: const Duration(
                        milliseconds: 200,
                      ),
                      turns: isExpanded ? 0.5 : 0,
                      child: widgets.IconButton(
                        iconSize: 22,
                        onPressed: expandedController.toggle,
                        icon: Icons.keyboard_arrow_down,
                      ),
                    );
                  },
                ),
              ],
            ),
            ExpandablePanel(
              controller: expandedController,
              collapsed: const SizedBox(),
              expanded: Column(
                children: [
                  const Divider(),
                  Text(
                    faq.body,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
