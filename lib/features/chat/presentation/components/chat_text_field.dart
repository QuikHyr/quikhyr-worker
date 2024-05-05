import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quikhyr_worker/common/quik_colors.dart';
import 'package:quikhyr_worker/features/chat/firebase_firestore_service.dart';
import 'package:quikhyr_worker/features/chat/media_service.dart';
import 'package:quikhyr_worker/features/chat/notification_service.dart';
import 'custom_text_form_field.dart';

class ChatTextField extends StatefulWidget {
  final String receiverId;
  const ChatTextField({super.key, required this.receiverId});

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final controller = TextEditingController();
  final notificationsService = NotificationsService();

  Uint8List? file;

  @override
  void initState() {
    notificationsService.getReceiverToken(widget.receiverId);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              controller: controller,
              hintText: 'Add Message...',
            ),
          ),
          const SizedBox(width: 5),
          CircleAvatar(
            backgroundColor: primary,
            radius: 20,
            child: IconButton(
                icon: const Icon(Icons.camera_alt, color: Colors.white),
                onPressed: () {
                  _sendImage();
                }),
          ),
          const SizedBox(width: 5),
          CircleAvatar(
            backgroundColor: primary,
            radius: 20,
            child: IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () {
                  _sendText(context);
                }),
          ),
        ],
      );

  Future<void> _sendText(BuildContext context) async {
    final String text = controller.text;
    if (text.isNotEmpty) {
      controller.clear();
      await FirebaseFirestoreService.addTextMessage(
        receiverId: widget.receiverId,
        content: text,
      ).catchError(
        (error) {
          debugPrint('Error sending message: $error');
        },
      );

      await notificationsService
          .sendNotification(
        body: text,
        senderId: FirebaseAuth.instance.currentUser!.uid,
      )
          .catchError((error) {
        debugPrint('Error sending notification: $error');
      });
    }
    if (context.mounted) {
      FocusScope.of(context).unfocus();
    }
  }

  Future<void> _sendImage() async {
    final pickedImage = await MediaService.pickImage();
    setState(() => file = pickedImage);
    if (file != null) {
      await FirebaseFirestoreService.addImageMessage(
        receiverId: widget.receiverId,
        file: file!,
      );
      await notificationsService.sendNotification(
        body: 'image........',
        senderId: FirebaseAuth.instance.currentUser!.uid,
      );
    }
  }
}
