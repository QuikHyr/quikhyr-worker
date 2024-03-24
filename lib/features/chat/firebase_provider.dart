import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quikhyr_worker/features/chat/firebase_firestore_service.dart';
import 'package:quikhyr_worker/models/chat_message_model.dart';
import 'package:quikhyr_worker/models/client_model.dart';

class FirebaseProvider extends ChangeNotifier {
  ScrollController scrollController = ScrollController();

  List<ClientModel> users = [];
  ClientModel? user;
  List<ChatMessageModel> messages = [];
  List<ClientModel> search = [];

  List<ClientModel> getAllClients() {
    try {
      FirebaseFirestore.instance
          .collection('clients')
          .snapshots(includeMetadataChanges: true)
          .listen((users) {
        this.users = users.docs.map((doc) {
          debugPrint(doc.data().toString());
          return ClientModel.fromMap(doc.data());
        }).toList();
        notifyListeners();
      });
    } catch (e) {
      print('Error fetching clients: $e');
    }
    return users;
  }

  ClientModel? getWorkerById(String userId) {
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
