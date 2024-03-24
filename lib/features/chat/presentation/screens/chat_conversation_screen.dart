import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quikhyr_worker/features/chat/firebase_provider.dart';
import 'package:quikhyr_worker/features/chat/presentation/components/chat_messages.dart';
import 'package:quikhyr_worker/features/chat/presentation/components/chat_text_field.dart';
import 'package:quikhyr_worker/models/client_model.dart';

class ChatConversationScreen extends StatefulWidget {
  final ClientModel client;
  const ChatConversationScreen({super.key, required this.client});

  @override
  State<ChatConversationScreen> createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
      .getMessages(widget.client.id);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            ChatMessages(
              receiverId: widget.client.id,
            ),
            ChatTextField(
              receiverId: widget.client.id,
            )
          ]),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.client.avatar),
          ),
          const SizedBox(width: 10),
          Text(widget.client.name),
        ],
      ),
    );
  }
}
