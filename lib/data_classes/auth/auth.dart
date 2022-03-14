import 'package:flutter/material.dart';

enum FavouriteFriendResult {
  removed,
  added,
  limitReached,
}

class ShowLoginModalOptions {
  final BuildContext context;
  final String loginCta;
  void Function() onSuccess;

  ShowLoginModalOptions({
    required this.context,
    required this.loginCta,
    required this.onSuccess,
  });
}
