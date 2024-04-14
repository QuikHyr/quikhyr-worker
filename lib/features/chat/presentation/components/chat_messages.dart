import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:quikhyr_worker/features/chat/firebase_provider.dart';
import 'package:quikhyr_worker/features/chat/presentation/components/chat_booking_bubble.dart';
import 'package:quikhyr_worker/models/chat_message_model.dart';
import 'empty_widget.dart';
import 'message_bubble.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key, required this.receiverId});
  final String receiverId;


  @override
  Widget build(BuildContext context) => Consumer<FirebaseProvider>(
        builder: (context, value, child) => value.messages.isEmpty
            ? const Expanded(
                child: EmptyWidget(icon: Icons.waving_hand, text: 'Say Hello!'),
              )
            : Expanded(
                child: ListView.builder(
                  controller:
                      Provider.of<FirebaseProvider>(context, listen: false)
                          .scrollController,
                  itemCount: value.messages.length,
                  itemBuilder: (context, index) {
                    debugPrint(value.messages[index].toString());
                    final messageType = value.messages[index].messageType;
                    final isMe = receiverId != value.messages[index].senderId;
                    debugPrint(isMe.toString());
                    switch (messageType) {
                      case MessageType.text:
                        return MessageBubble(
                          isMe: isMe,
                          isImage: false,
                          message: value.messages[index],
                        );
                      case MessageType.image:
                        return MessageBubble(
                          isMe: isMe,
                          isImage: true,
                          message: value.messages[index],
                        );
                      case MessageType.booking:
                        return BookingRequestBubble(
                          
                          isMe: isMe,
                          message: value.messages[index],
                        );
                    }
                  },
                ),
              ),
      );
}
