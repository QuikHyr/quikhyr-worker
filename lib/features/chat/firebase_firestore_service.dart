import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quikhyr_worker/models/chat_list_model.dart';
import 'package:quikhyr_worker/models/chat_message_model.dart';
import 'firebase_storage_service.dart';

class FirebaseFirestoreService {
  static final firestore = FirebaseFirestore.instance;

  // static Future<void> createUser({
  //   required String name,
  //   required String image,
  //   required String email,
  //   required String uid,
  // }) async {
  //   final user = ClientModel(
  //     id: uid,
  //     email: email,
  //     name: name,
  //   );

  //   await firestore
  //       .collection('users')
  //       .doc(uid)
  //       .set(user.toJson());
  // }

  static Future<void> addTextMessage({
    required String content,
    required String receiverId,
  }) async {
    final message = ChatMessageModel(
      content: content,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.text,
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );
    await _addMessageToChat(receiverId, message);
  }

    static Future<void> addBookingMessage({
    required String subserviceId,
    required String content,
    required String receiverId,
    required String unit,
    required num ratePerUnit,
    required DateTime timeslot,
  }) async {
    final message = ChatMessageModel(
      subserviceId: subserviceId,
      isAccepted: false,
      content: content,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.booking,
      senderId: FirebaseAuth.instance.currentUser!.uid,
      unit: unit,
      ratePerUnit: ratePerUnit,
      timeslot: timeslot,
    );
    await _addMessageToChat(receiverId, message);
  }

  static Future<void> addImageMessage({
    required String receiverId,
    required Uint8List file,
  }) async {
    final image = await FirebaseStorageService.uploadImage(
        file, 'image/chat/${DateTime.now()}');

    final message = ChatMessageModel(
      content: image,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.image,
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );
    await _addMessageToChat(receiverId, message);
  }

  static Future<void> _addMessageToChat(
  String receiverId,
  ChatMessageModel message,
) async {
  // Generate a new document ID
  var newDocId = firestore.collection('workers').doc().id;

  // Add the message to the worker's collection using the new document ID
  await firestore
      .collection('workers')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('chat')
      .doc(receiverId)
      .collection('messages')
      .doc(newDocId)
      .set(message.toJson());

  // Add the same message to the client's collection using the same document ID
  await firestore
      .collection('clients')
      .doc(receiverId)
      .collection('chat')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('messages')
      .doc(newDocId)
      .set(message.toJson());
}


  static Future<void> updateUserData(
          Map<String, dynamic> data) async =>
      await firestore
          .collection('workers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(data);

  static Future<List<ChatListModel>> searchUser(
      String name) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('clients')
        .where("name", isGreaterThanOrEqualTo: name)
        .get();

    return snapshot.docs
        .map((doc) => ChatListModel.fromMap(doc.data()))
        .toList();
  }
}
