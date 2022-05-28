import "dart:async";

import "package:dartx/dartx.dart";
import "package:firebase_database/firebase_database.dart";
import "package:flutter_chat_types/flutter_chat_types.dart" as types;
import "package:paladinsedge/constants.dart" as constants;

enum ChatConnectionState { connected, disconnected, unknown }

class RealtimeGlobalChat {
  static final _connectedRef = FirebaseDatabase.instance.ref(".info/connected");
  static DatabaseReference? _globalChatRef;
  static DatabaseReference? _messagesRef;
  static DatabaseReference? _playersOnlineRef;
  static DatabaseReference? _playerRef;

  /// Used to initialize ref object
  /// should be called Env after is setup
  static void initialize() {
    _globalChatRef = FirebaseDatabase.instance.ref(
      "${constants.Env.appType}-global-chat",
    );
    _messagesRef = _globalChatRef!.child("messages");
    _playersOnlineRef = _globalChatRef!.child("players-online");
    _keepChatMessagesSynced();
  }

  /// Listens for connection events, initially when GlobalChat screen mounts
  /// user would be connected to RTDB, so [_setPlayerOnline] is called
  /// when user disconnects unintentionally, [_registerDisconnect] is called from db
  /// and player online data is removed from RTDB.
  static StreamSubscription<DatabaseEvent> connectionListener({
    required types.User user,
    required void Function()? onConnected,
    required void Function()? onDisconnected,
  }) {
    return _connectedRef.onValue.listen((event) {
      final connected = event.snapshot.value as bool? ?? false;
      if (connected) {
        _setPlayerOnline(user);
        onConnected?.call();
      } else {
        onDisconnected?.call();
      }
    });
  }

  /// manually remove player online data
  /// called when GlobalChat screen unmounts
  static void disconnect() async {
    if (_playerRef == null) return;
    await _playerRef!.onDisconnect().cancel();
    await _playerRef!.remove();
    _playerRef = null;
  }

  /// read messages from database
  static Future<List<types.TextMessage>> getMessages() async {
    if (_messagesRef == null) return [];

    final snapshot = await _messagesRef!.get();
    if (!snapshot.exists) return [];
    final json = snapshot.value as Map;
    final jsonMessages = json.values;

    final messages = jsonMessages
        .mapNotNull(_convertSnapshotToMessages)
        .sortedByDescending((_) => _.createdAt!)
        .toList();

    return messages;
  }

  /// read players online from database
  static Future<Map<String, types.User>> getPlayersOnline() async {
    if (_playersOnlineRef == null) return {};

    final snapshot = await _playersOnlineRef!.get();
    if (!snapshot.exists) return {};
    final json = snapshot.value as Map;
    final jsonKeys = json.keys;

    final Map<String, types.User> playersOnline = {};
    for (var jsonKey in jsonKeys) {
      final jsonUser = json[jsonKey];
      final user = _convertSnapshotToUser(jsonUser);

      if (user != null) playersOnline[jsonKey as String] = user;
    }

    return playersOnline;
  }

  /// add listener to message events
  static StreamSubscription<DatabaseEvent>? messageListener(
    String lastReadMessageKey,
    void Function(types.TextMessage) onEvent,
  ) {
    if (_messagesRef == null) return null;

    // start listening for messages that are after the key last read
    return _messagesRef!
        .startAfter(
          null,
          key: lastReadMessageKey,
        )
        .onChildAdded
        .listen(
      (event) {
        if (!event.snapshot.exists) return;
        final message = _convertSnapshotToMessages(event.snapshot.value);
        if (message != null) onEvent(message);
      },
    );
  }

  /// add listener to message change events
  static StreamSubscription<DatabaseEvent>? messageChangedListener(
    void Function(types.TextMessage) onEvent,
  ) {
    if (_messagesRef == null) return null;

    // start listening for message being changed
    return _messagesRef!.onChildChanged.listen(
      (event) {
        if (!event.snapshot.exists) return;
        final message = _convertSnapshotToMessages(event.snapshot.value);
        if (message != null) onEvent(message);
      },
    );
  }

  /// add listener to message remove events
  static StreamSubscription<DatabaseEvent>? messageRemoveListener(
    void Function(String id) onEvent,
  ) {
    if (_messagesRef == null) return null;

    // start listening for message being removed
    return _messagesRef!.onChildRemoved.listen(
      (event) {
        if (!event.snapshot.exists) return;
        final data = event.snapshot.value as Map?;
        if (data == null) return;

        final id = data["id"] as String?;
        if (id != null) onEvent(id);
      },
    );
  }

  /// add listener to players online events
  static StreamSubscription<DatabaseEvent>? playersOnlineListener(
    void Function(types.User) onEvent,
  ) {
    if (_playersOnlineRef == null) return null;

    // start listening for players online
    return _playersOnlineRef!.onChildAdded.listen(
      (event) {
        if (!event.snapshot.exists) return;
        final playerOnline = _convertSnapshotToUser(event.snapshot.value);
        if (playerOnline != null) onEvent(playerOnline);
      },
    );
  }

  /// add listener to players online change events
  static StreamSubscription<DatabaseEvent>? playersOnlineChangedListener(
    void Function(types.User) onEvent,
  ) {
    if (_playersOnlineRef == null) return null;

    // start listening for players online being changed
    return _playersOnlineRef!.onChildChanged.listen(
      (event) {
        if (!event.snapshot.exists) return;
        final playerOnline = _convertSnapshotToUser(event.snapshot.value);
        if (playerOnline != null) onEvent(playerOnline);
      },
    );
  }

  /// add listener to players online remove events
  static StreamSubscription<DatabaseEvent>? playersOnlineRemoveListener(
    void Function(String id) onEvent,
  ) {
    if (_playersOnlineRef == null) return null;

    // start listening for players online being removed
    return _playersOnlineRef!.onChildRemoved.listen(
      (event) {
        if (!event.snapshot.exists) return;
        final data = event.snapshot.value as Map?;
        if (data == null) return;

        final id = data["id"] as String?;
        if (id != null) onEvent(id);
      },
    );
  }

  /// writes some json data to realtime database
  /// returns true if message successfully delivered
  static Future<bool> sendMessage(types.TextMessage data) async {
    if (_messagesRef == null) return false;

    try {
      await _messagesRef!
          .child(data.createdAt.toString())
          .set(data.toJson())
          .timeout(const Duration(seconds: 10));

      return true;
    } catch (e) {
      return false;
    }
  }

  /// sets the player in database
  static Future<bool> setPlayer(types.User player) async {
    if (_playersOnlineRef == null) return false;

    try {
      await _playersOnlineRef!.child(player.id).set(player.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }

  /// converts snapshot data from firebase to messages
  static types.TextMessage? _convertSnapshotToMessages(
    Object? snapshotValue,
  ) {
    final data = snapshotValue as Map?;
    if (data == null) return null;
    final author = _convertSnapshotToUser(data["author"]);
    final id = data["id"];
    final createdAt = data["createdAt"];
    final text = data["text"];

    // check if any of the above values are null
    if ([createdAt, id, author, text].mapNotNull((_) => _).length != 4) {
      return null;
    }

    return types.TextMessage(
      author: author!,
      id: id as String,
      createdAt: createdAt as int,
      text: text as String,
      status: _getStatus(data["status"] as String?),
    );
  }

  /// converts snapshot data from firebase to user
  static types.User? _convertSnapshotToUser(
    Object? snapshotValue,
  ) {
    final data = snapshotValue as Map?;
    if (data == null) return null;

    final id = data["id"];
    final metadata = data["metadata"];
    Map<String, dynamic>? metadataMap;
    if (id == null) return null;
    if (metadata != null) {
      metadataMap = {"typing": metadata["typing"]};
    }

    return types.User(
      id: id as String,
      imageUrl: data["imageUrl"] as String?,
      firstName: data["firstName"] as String?,
      metadata: metadataMap,
    );
  }

  /// gets the Status type from string
  static types.Status? _getStatus(String? status) {
    if (status == null) return null;

    const statusMap = {
      "delivered": types.Status.delivered,
      "error": types.Status.error,
      "seen": types.Status.seen,
      "sending": types.Status.sending,
      "sent": types.Status.sent,
    };

    return statusMap[status];
  }

  /// When user visits the GlobalChat page
  /// user is set as online in the database
  static void _setPlayerOnline(types.User user) {
    if (_playersOnlineRef == null) return;
    _playerRef = _playersOnlineRef!.child(user.id);
    _playerRef!.set(user.toJson());
    // register disconnect handler
    _registerDisconnect();
  }

  /// disconnects the user and sets _playerRef to null
  static void _registerDisconnect() async {
    if (_playerRef == null) return;
    await _playerRef!.onDisconnect().remove();
  }

  /// Keeps the chat synced offline
  static void _keepChatMessagesSynced() {
    if (_messagesRef == null) return;
    if (constants.isWeb) return;

    _messagesRef!.keepSynced(true);
  }
}
