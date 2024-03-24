

class ChatRepository {
  // Stream<List<ChatModel>> getChats() {
  //   return databaseReference.child('chats').onValue.map((event) {
  //     if (event.snapshot.value is Map) {
  //       return (event.snapshot.value as Map)
  //           .entries
  //           .map(
  //             (entry) => ChatModel.fromMap(
  //                 Map<String, dynamic>.from(entry.value), entry.key),
  //           )
  //           .toList();
  //     } else {
  //       debugPrint('No chats found');
  //       return [];
  //     }
  //   });
  // }

  // Future<void> addMessage(String chatId, ChatMessageModel message) {
  //   return databaseReference.child('chats').child(chatId).child('messages').push().set(message.toMap());
  // }
}
