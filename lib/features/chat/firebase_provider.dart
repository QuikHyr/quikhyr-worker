import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quikhyr_worker/features/chat/firebase_firestore_service.dart';
import 'package:quikhyr_worker/models/chat_list_model.dart';
import 'package:quikhyr_worker/models/chat_message_model.dart';
import 'package:quikhyr_worker/models/client_model.dart';

class FirebaseProvider extends ChangeNotifier {
  ScrollController scrollController = ScrollController();

  List<ChatListModel> users = [];
  ClientModel? user;
  List<ChatMessageModel> messages = [];
  List<ChatListModel> search = [];

Stream<List<ChatListModel>> getAllClientsWithLastMessageStream() {
  // Create a stream controller
  StreamController<List<ChatListModel>> streamController = StreamController();

  FirebaseFirestore.instance.collection('clients').snapshots().listen((clientSnapshot) {
    clientSnapshot.docs.forEach((doc) {
      var clientData = doc.data() as Map<String, dynamic>?;

      if (clientData != null) {
        // Listen to the last message for this client in real-time
        FirebaseFirestore.instance
            .collection('workers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('chat').doc(doc.id).collection('messages')
            .orderBy('sentTime', descending: true)
            .limit(1)
            .snapshots().listen((messageSnapshot) {
          if (messageSnapshot.docs.isNotEmpty) {
            var messageData = messageSnapshot.docs.first.data() as Map<String, dynamic>;
            String lastMessage = messageData['content'] ?? '';
            DateTime sentTime = (messageData['sentTime'] as Timestamp).toDate();
            MessageType messageType = stringToMessageType(messageData['messageType']);

            // Construct the ChatListModel
            ChatListModel clientWithLastMessage = ChatListModel(
              name: clientData['name'],
              id: doc.id,
              isVerified: clientData['isVerified'] ?? false,
              isActive: clientData['isActive'] ?? false,
              avatar: clientData['avatar'] ?? '',
              lastMessage: lastMessage,
              sentTime: sentTime,
              messageType: messageType,
            );

            // Update the specific client with the new last message
            int index = users.indexWhere((user) => user.id == doc.id);
            if (index != -1) {
              users[index] = clientWithLastMessage;
            } else {
              users.add(clientWithLastMessage);
            }

            // Add the updated list of clients with the last message to the stream
            streamController.add(users);
          }
        });
      }
    });
  });

  return streamController.stream;
}



  ClientModel? getClientById(String userId) {
    FirebaseFirestore.instance
        .collection('clients')
        .doc(userId)
        .snapshots(includeMetadataChanges: true)
        .listen((user) {
      this.user = ClientModel.fromMap(user.data()!);
      notifyListeners();
    });
    return user;
  }


  List<ChatMessageModel> getMessages(String receiverId) {
    FirebaseFirestore.instance
        .collection('workers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .orderBy('sentTime', descending: false)
        .snapshots(includeMetadataChanges: true)
        .listen((messages) {
      this.messages = messages.docs
          .map((doc) => ChatMessageModel.fromJson(doc.data()))
          .toList();
      notifyListeners();

      scrollDown();
    });
    return messages;
  }

  void scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });

  Future<void> searchUser(String name) async {
    search = await FirebaseFirestoreService.searchUser(name);
    notifyListeners();
  }
}
