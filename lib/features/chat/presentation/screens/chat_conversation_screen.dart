import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quikhyr_worker/features/chat/firebase_provider.dart';
import 'package:quikhyr_worker/features/chat/presentation/components/chat_messages.dart';
import 'package:quikhyr_worker/features/chat/presentation/components/chat_text_field.dart';
import 'package:quikhyr_worker/models/chat_list_model.dart';

class ChatConversationScreen extends StatefulWidget {
  final String clientId;
  const ChatConversationScreen({super.key, required this.clientId});

  @override
  State<ChatConversationScreen> createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
      ..getClientById(widget.clientId)
      ..getMessages(widget.clientId);
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
              receiverId: widget.clientId,
            ),
            ChatTextField(
              receiverId: widget.clientId,
            )
          ]),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
        title: Consumer<FirebaseProvider>(
            builder: (context, value, child) => value.user != null
                ? Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(value.user!.avatar),
                      ),
                      const SizedBox(width: 10),
                      Text(value.user!.name),
                    ],
                  )
                : const SizedBox()));
  }
}
