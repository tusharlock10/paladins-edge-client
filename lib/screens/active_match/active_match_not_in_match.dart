import 'package:flutter/material.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;

class ActiveMatchNotInMatch extends StatelessWidget {
  final String status;
  final bool isUserPlayer;

  const ActiveMatchNotInMatch({
    required this.status,
    required this.isUserPlayer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed(
        [
          SizedBox(
            height: utilities.getBodyHeight(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  status,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${isUserPlayer ? "You are" : "Player is"} currently not in a match',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
