import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:paladinsedge/theme/colors.dart';
import 'package:paladinsedge/theme/fonts.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

final lightGlobalChatTheme = DefaultChatTheme(
  receivedMessageBodyTextStyle: TextStyle(
    color: Colors.black54,
    fontSize: 16,
    fontFamily: Fonts.primary,
  ),
  sentMessageBodyTextStyle: TextStyle(
    color: Colors.black54,
    fontSize: 16,
    fontFamily: Fonts.primary,
  ),
  inputTextColor: Colors.black87,
  primaryColor: Colors.white,
  inputBackgroundColor: Colors.white,
  inputBorderRadius: const BorderRadius.all(Radius.circular(10)),
  backgroundColor: themeMaterialColor.shade50,
  secondaryColor: Colors.white70,
  userAvatarNameColors: const [
    Colors.green,
    Colors.orange,
    Colors.yellow,
    Colors.red,
    Colors.blueGrey,
    Colors.blue,
    Colors.lightBlue,
    Colors.brown,
  ],
  userNameTextStyle: TextStyle(
    fontSize: 12,
    fontFamily: Fonts.secondaryAccent,
  ),
  messageBorderRadius: 10,
  inputTextStyle: TextStyle(
    fontSize: 14,
    fontFamily: Fonts.primary,
  ),
  inputMargin: const EdgeInsets.all(10),
  deliveredIcon: const Icon(
    FeatherIcons.check,
    color: themeMaterialColor,
    size: 16,
  ),
  sendingIcon: const widgets.LoadingIndicator(
    color: themeMaterialColor,
    size: 14,
    lineWidth: 1.2,
  ),
  sendButtonIcon: const Icon(
    FeatherIcons.arrowRight,
    color: themeMaterialColor,
    size: 20,
  ),
);

final darkGlobalChatTheme = DefaultChatTheme(
  receivedMessageBodyTextStyle: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: Fonts.primary,
  ),
  sentMessageBodyTextStyle: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: Fonts.primary,
  ),
  primaryColor: darkThemeMaterialColor.shade50,
  inputBackgroundColor: darkThemeMaterialColor.shade50,
  inputBorderRadius: const BorderRadius.all(Radius.circular(10)),
  backgroundColor: darkThemeMaterialColor.shade500,
  secondaryColor: darkThemeMaterialColor.shade300,
  userAvatarNameColors: [
    Colors.green.shade300,
    Colors.orange.shade300,
    Colors.yellow.shade300,
    Colors.red.shade300,
    Colors.blueGrey.shade300,
    Colors.blue.shade300,
    Colors.lightBlue.shade300,
    Colors.brown.shade300,
  ],
  userNameTextStyle: TextStyle(
    fontSize: 12,
    fontFamily: Fonts.secondaryAccent,
  ),
  messageBorderRadius: 10,
  inputTextStyle: TextStyle(
    fontSize: 14,
    fontFamily: Fonts.primary,
  ),
  inputMargin: const EdgeInsets.all(10),
  deliveredIcon: const Icon(
    FeatherIcons.check,
    color: Colors.white,
    size: 16,
  ),
  sendingIcon: const widgets.LoadingIndicator(
    color: Colors.white,
    size: 14,
    lineWidth: 1.2,
  ),
  sendButtonIcon: Icon(
    FeatherIcons.arrowRight,
    color: themeMaterialColor.shade50,
    size: 20,
  ),
);
