import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:paladinsedge/constants.dart' as constants;

class RealtimeGlobalChat {
  static final _ref = FirebaseDatabase.instance.ref("globalChat");

  /// Keeps the chat synced offline
  static void keepChatSynced() {
    if (!constants.isWeb) {
      _ref.keepSynced(true);
    }
  }

  /// read contents of database
  static Future<List<types.TextMessage>> readAllMessages() async {
    final snapshot = await _ref.get();
    if (!snapshot.exists) return [];
    final json = snapshot.value as Map;
    final jsonMessages = json.values;

    return jsonMessages.mapNotNull(_convertSnapshotToMessages).toList();
  }

  /// add listener to database events
  static StreamSubscription listenData(
    void Function(types.TextMessage) onEvent,
  ) {
    return _ref.onChildAdded.listen(
      (event) {
        if (!event.snapshot.exists) return;
        final message = _convertSnapshotToMessages(event.snapshot.value);
        if (message != null) onEvent(message);
      },
    );
  }

  /// writes some json data to realtime database
  static Future<void> sendMessage(types.TextMessage data) {
    return _ref.push().set(data.toJson());
  }

  /// converts weird fucking crap coming from
  /// firebase into something that makes sense
  static types.TextMessage? _convertSnapshotToMessages(
    Object? snapshotValue,
  ) {
    final data = snapshotValue as Map?;
    if (data == null) return null;

    return types.TextMessage(
      author: types.User(
        id: data["author"]["id"] as String,
        firstName: data["author"]["firstName"] as String?,
        imageUrl: data["author"]["imageUrl"] as String?,
      ),
      id: data["id"] as String,
      createdAt: data["createdAt"] as int?,
      text: data["text"] as String,
    );
  }
}
