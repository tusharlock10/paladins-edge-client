import "package:flutter/material.dart";

enum FavouriteFriendResult {
  removed,
  added,
  limitReached,
  unauthorized,
}

class ShowLoginModalOptions {
  final BuildContext context;
  final String loginCta;

  ShowLoginModalOptions({
    required this.context,
    required this.loginCta,
  });
}

class SignInProviderResponse {
  final bool result;
  final int? errorCode;
  final String? errorMessage;

  SignInProviderResponse({
    required this.result,
    this.errorCode,
    this.errorMessage,
  });
}
