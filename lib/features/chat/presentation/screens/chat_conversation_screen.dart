import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quikhyr_worker/common/quik_colors.dart';
import 'package:quikhyr_worker/common/widgets/longIconButton.dart';
import 'package:quikhyr_worker/features/auth/presentation/components/my_text_field.dart';
import 'package:quikhyr_worker/features/chat/firebase_firestore_service.dart';
import 'package:quikhyr_worker/features/chat/firebase_provider.dart';
import 'package:quikhyr_worker/features/chat/notification_service.dart';
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
  final unitController = TextEditingController();
  final pricePerUnitController = TextEditingController();
  final NotificationsService notificationsService = NotificationsService();
  DateTime selectedDateTime = DateTime.now();

  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
      ..getClientById(widget.clientId)
      ..getMessages(widget.clientId);
    notificationsService.getReceiverToken(widget.clientId);
    super.initState();
  }

    Future<void> _sendBooking(BuildContext context) async {
    if (unitController.text.isNotEmpty && pricePerUnitController.text.isNotEmpty) {
      await FirebaseFirestoreService.addBookingMessage(
        unit: unitController.text,
        pricePerUnit: num.parse(pricePerUnitController.text),
        receiverId: widget.clientId,
        content: "Booking Request from ${FirebaseAuth.instance.currentUser!.uid}",
        timeslot: selectedDateTime,
      );
      await notificationsService.sendNotification(
        body: "Booking Request from ${FirebaseAuth.instance.currentUser!.uid}",
        senderId: FirebaseAuth.instance.currentUser!.uid,
      );
      unitController.clear();
      pricePerUnitController.clear();
      if(context.mounted){
      FocusScope.of(context).unfocus();

      }
    }
    if(context.mounted){
      FocusScope.of(context).unfocus();

      }
  }

  @override
  void dispose() {
    unitController.dispose();
    pricePerUnitController.dispose();
    super.dispose();
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
        actions: [
          IconButton(
              onPressed: () {
                // Handle call button press
              },
              icon: const Icon(Icons.call)),
          IconButton(
            icon: const Icon(Icons.request_quote),
            onPressed: () {
              showModalBottomSheet(
                barrierLabel: 'Work Proposal',
                barrierColor: background.withOpacity(0.2),
                backgroundColor: background,
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Container(
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Work Proposal',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: onSecondary),
                            ),
                            const SizedBox(height: 16),
                            MyTextField(
                              enabledBorderColor: textInputBackgroundColor,
                              controller: unitController,
                              hintText: 'Enter Unit',
                              obscureText: false,
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(height: 16),
                            MyTextField(
                              enabledBorderColor: textInputBackgroundColor,
                                controller: pricePerUnitController,
                                hintText: 'Enter Price Per Unit',
                                obscureText: false,
                                keyboardType:
                                    const TextInputType.numberWithOptions()),
                            const SizedBox(height: 16),
                            LongIconButton(
                              backgroundColor: textInputBackgroundColor,
                              foregroundColor: secondary,
                              text: 'Select Date and Time',
                              onPressed: () async {
                                final selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );

                                if (selectedDate != null && context.mounted) {
                                  final selectedTime = await showTimePicker(
                                    context: context,
                                    initialTime:
                                        TimeOfDay.fromDateTime(DateTime.now()),
                                  );

                                  if (selectedTime != null) {
                                    setState(() {
                                      selectedDateTime = DateTime(
                                        selectedDate.year,
                                        selectedDate.month,
                                        selectedDate.day,
                                        selectedTime.hour,
                                        selectedTime.minute,
                                      );
                                    });
                                  }
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Selected Date and Time: ${DateFormat('yyyy-MM-dd – kk:mm').format(selectedDateTime)}',
                              style:
                                  const TextStyle(color: onSecondary, fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            LongIconButton(
                              backgroundColor: textInputBackgroundColor,
                              foregroundColor: secondary,
                              onPressed: () {
                                _sendBooking(context);
                                Navigator.pop(context);
                              },
                              text: 'Send Proposal',
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          )
        ],
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
