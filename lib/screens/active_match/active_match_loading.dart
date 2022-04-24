import 'package:flutter/material.dart';
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class ActiveMatchLoading extends StatelessWidget {
  final bool isLoadingPlayerStatus;
  final bool isUserPlayer;
  const ActiveMatchLoading({
    required this.isLoadingPlayerStatus,
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
            child: isLoadingPlayerStatus
                ? const widgets.LoadingIndicator(
                    lineWidth: 2,
                    size: 28,
                    label: Text('Getting active match'),
                  )
                : Center(
                    child: Text(
                      'Unable to fetch ${isUserPlayer ? "your" : "player"} active match',
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
