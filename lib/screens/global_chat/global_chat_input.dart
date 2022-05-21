import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/utilities/index.dart' as utilities;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class GlobalChatInput extends HookWidget {
  final types.User user;
  final Map<String, types.User> playersOnline;
  final void Function(String) onSendPressed;
  final void Function(bool) onTyping;

  const GlobalChatInput({
    required this.user,
    required this.playersOnline,
    required this.onSendPressed,
    required this.onTyping,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables
    final textTheme = Theme.of(context).textTheme;
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final chatTheme =
        isLightTheme ? theme.lightGlobalChatTheme : theme.darkGlobalChatTheme;

    // State
    final isValid = useState(false);

    // Hooks
    final textController = useTextEditingController();

    // Methods
    final onChanged = useCallback(
      (String value) {
        isValid.value = textController.text.isNotBlank;
        onTyping(isValid.value);
      },
      [],
    );

    final onSend = useCallback(
      () {
        if (isValid.value) {
          onSendPressed(textController.text);
          textController.text = '';
          isValid.value = false;
          onTyping(isValid.value);
        }
      },
      [],
    );

    final typingPlayers = useMemoized(
      () {
        return playersOnline.values.mapNotNull((playerOnline) {
          final isTyping = playerOnline.metadata?['typing'] as bool? ?? false;
          if (user.id == playerOnline.id) return null;

          return isTyping ? playerOnline : null;
        });
      },
      [playersOnline],
    );

    final playersTypingText = useMemoized(
      () {
        return typingPlayers.length == 1
            ? '${typingPlayers.first.firstName} is typing ...'
            : typingPlayers.length == 2
                ? '${typingPlayers.map((_) => _.firstName).join(', ')} are typing ...'
                : '${typingPlayers.length} players are typing ...';
      },
      [typingPlayers],
    );

    final playersTypingAvatarUrl = useMemoized(
      () {
        return typingPlayers.take(3).mapNotNull(
              (_) => utilities.getSmallAsset(_.imageUrl),
            );
      },
      [typingPlayers],
    );

    return Padding(
      padding: chatTheme.inputPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: typingPlayers.isEmpty
                ? const SizedBox()
                : SizedBox(
                    height: 30,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          ...playersTypingAvatarUrl.map(
                            (avatarUrl) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              child: widgets.ElevatedAvatar(
                                imageUrl: avatarUrl,
                                size: 10,
                                borderRadius: 10,
                                elevation: 0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              playersTypingText,
                              style: textTheme.bodyText1,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            elevation: 7,
            shadowColor: theme.themeMaterialColor.shade50,
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    maxLength: 2048,
                    minLines: 1,
                    maxLines: 10,
                    style: const TextStyle(fontSize: 16),
                    onSubmitted: (_) => onSend(),
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      fillColor: chatTheme.inputBackgroundColor,
                      border: InputBorder.none,
                      filled: true,
                      counterText: '',
                      hintText: 'Message...',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Visibility(
                    visible: isValid.value,
                    child: GestureDetector(
                      onTap: onSend,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: chatTheme.sendButtonIcon,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
