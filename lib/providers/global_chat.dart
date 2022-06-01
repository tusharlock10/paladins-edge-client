import "dart:async";

import "package:dartx/dartx.dart";
import "package:firebase_database/firebase_database.dart";
import "package:flutter/foundation.dart";
import "package:flutter_chat_types/flutter_chat_types.dart" as types;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:paladinsedge/models/index.dart" as models;
import "package:paladinsedge/providers/auth.dart" as auth_provider;
import "package:paladinsedge/utilities/index.dart" as utilities;
import "package:uuid/uuid.dart";

class _GlobalChatNotifier extends ChangeNotifier {
  bool isInit = false;
  final bool isGuest;
  List<types.TextMessage> messages = [];
  Map<String, types.User> playersOnline = {};
  utilities.ChatConnectionState connectionState =
      utilities.ChatConnectionState.unknown;
  types.User globalChatUser;

  String? _lastReadMessageKey;
  final models.Player? _player;
  StreamSubscription<DatabaseEvent>? _messageListener;
  StreamSubscription<DatabaseEvent>? _messageChangedListener;
  StreamSubscription<DatabaseEvent>? _messageRemoveListener;
  StreamSubscription<DatabaseEvent>? _playersOnlineListener;
  StreamSubscription<DatabaseEvent>? _playersOnlineChangedListener;
  StreamSubscription<DatabaseEvent>? _playersOnlineRemoveListener;
  StreamSubscription<DatabaseEvent>? _connectionListener;

  _GlobalChatNotifier({
    required models.Player? player,
    required this.isGuest,
  })  : _player = player,
        globalChatUser = player == null
            ? types.User(id: const Uuid().v4())
            : types.User(
                id: player.playerId,
                imageUrl: player.avatarUrl,
                firstName: player.name,
                metadata: const {
                  "typing": false,
                },
              );

  /// initializes the GlobalChat
  /// 1) gets all messages from RTDB
  /// 2) gets all online players from RTDB
  /// 3) initializes listeners
  void initialize() async {
    isInit = false;
    utilities.postFrameCallback(notifyListeners);

    final results = await Future.wait([
      utilities.RealtimeGlobalChat.getMessages(),
      utilities.RealtimeGlobalChat.getPlayersOnline(),
    ]);

    messages = [...results.first as List<types.TextMessage>];
    playersOnline = {...results[1] as Map<String, types.User>};
    isInit = true;
    _lastReadMessageKey =
        messages.isNotEmpty ? messages.first.createdAt.toString() : null;

    _initializeListeners();
    utilities.postFrameCallback(notifyListeners);
  }

  /// send typing metadata of the player to RTDB
  void sendTypingMetadata(bool isTyping) {
    globalChatUser = globalChatUser.copyWith(
      firstName: globalChatUser.firstName,
      imageUrl: globalChatUser.imageUrl,
      lastName: globalChatUser.lastName,
      lastSeen: globalChatUser.lastSeen,
      role: globalChatUser.role,
      updatedAt: globalChatUser.updatedAt,
      metadata: {
        "typing": isTyping,
      },
    );
    utilities.RealtimeGlobalChat.setPlayer(globalChatUser);
    utilities.postFrameCallback(notifyListeners);
  }

  /// send a new message to RTDB
  Future<void> sendNewMessage(String text) async {
    if (isGuest) return;

    // create a message with status = sending
    var message = types.TextMessage(
      text: text,
      author: globalChatUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      status: types.Status.sending,
    );

    // add this message in messages
    messages = [message, ...messages];

    // set status = sent and deliver the message
    message = message.copyWith(status: types.Status.sent) as types.TextMessage;
    utilities.postFrameCallback(notifyListeners);

    final isSuccessful = await utilities.RealtimeGlobalChat.sendMessage(
      message,
    );

    if (!isSuccessful) {
      // if cannot send message, change status to error
      message = message.copyWith(
        status: types.Status.error,
      ) as types.TextMessage;
    }

    final messageIndex = messages.indexWhere(
      (_) => _.id == message.id,
    );
    messages[messageIndex] = message;
    messages = [...messages];
    utilities.postFrameCallback(notifyListeners);
  }

  /// uninitialize all listeners upon
  /// to be used on GlobalChat screen unmount
  void uninitialize() async {
    isInit = false;
    final futures = [
      _messageListener,
      _messageChangedListener,
      _messageRemoveListener,
      _playersOnlineListener,
      _playersOnlineChangedListener,
      _playersOnlineRemoveListener,
      _connectionListener,
    ].mapNotNull((_) => _?.cancel());
    await Future.wait(futures);
    utilities.RealtimeGlobalChat.disconnect();
  }

  /// listener for receiving new messages
  void _onMessage(types.TextMessage message) {
    if (message.author.id != _player?.playerId) {
      messages = [message, ...messages];
      utilities.postFrameCallback(notifyListeners);
    }
  }

  /// listener for changes to existing messages
  void _onMessageChanged(types.TextMessage message) {
    final index = messages.indexWhere((_) => _.id == message.id);
    if (index == -1) return;

    messages[index] = message;
    messages = [...messages];
    utilities.postFrameCallback(notifyListeners);
  }

  /// listener for messages being removed
  void _onMessageRemove(String id) {
    final index = messages.indexWhere((_) => _.id == id);
    if (index == -1) return;

    messages.removeAt(index);
    messages = [...messages];
    utilities.postFrameCallback(notifyListeners);
  }

  /// listener for another player coming online
  void _onPlayerOnline(types.User user) {
    playersOnline = {...playersOnline, user.id: user};
    utilities.postFrameCallback(notifyListeners);
  }

  /// listener for another player online data changes
  void _onPlayerOnlineChanged(types.User user) {
    playersOnline = {...playersOnline, user.id: user};
    utilities.postFrameCallback(notifyListeners);
  }

  /// listener for another online player being removed
  void _onPlayerOnlineRemove(String id) {
    playersOnline.remove(id);
    playersOnline = {...playersOnline};
    utilities.postFrameCallback(notifyListeners);
  }

  /// listener for when the player connects to RTDB
  void _onConnected() {
    connectionState = utilities.ChatConnectionState.connected;
    utilities.postFrameCallback(notifyListeners);
  }

  /// listener for when the player disconnects from RTDB
  void _onDisconnected() {
    connectionState = utilities.ChatConnectionState.disconnected;
    utilities.postFrameCallback(notifyListeners);
  }

  /// initialize all listeners
  void _initializeListeners() {
    //
    if (_lastReadMessageKey == null) return;

    // pass the lastReadMessageKey to start listening from that point
    _messageListener = utilities.RealtimeGlobalChat.messageListener(
      _lastReadMessageKey!,
      _onMessage,
    );
    _messageChangedListener =
        utilities.RealtimeGlobalChat.messageChangedListener(
      _onMessageChanged,
    );
    _messageRemoveListener = utilities.RealtimeGlobalChat.messageRemoveListener(
      _onMessageRemove,
    );
    _playersOnlineListener = utilities.RealtimeGlobalChat.playersOnlineListener(
      _onPlayerOnline,
    );
    _playersOnlineChangedListener =
        utilities.RealtimeGlobalChat.playersOnlineChangedListener(
      _onPlayerOnlineChanged,
    );
    _playersOnlineRemoveListener =
        utilities.RealtimeGlobalChat.playersOnlineRemoveListener(
      _onPlayerOnlineRemove,
    );
    _connectionListener = utilities.RealtimeGlobalChat.connectionListener(
      user: globalChatUser,
      onConnected: _onConnected,
      onDisconnected: _onDisconnected,
    );
  }
}

/// Provider to handle globalChat
final globalChat = ChangeNotifierProvider(
  (ref) {
    final player = ref.watch(auth_provider.auth.select((_) => _.player));
    final isGuest = ref.watch(auth_provider.auth.select((_) => _.isGuest));

    return _GlobalChatNotifier(
      player: player,
      isGuest: isGuest,
    );
  },
);
