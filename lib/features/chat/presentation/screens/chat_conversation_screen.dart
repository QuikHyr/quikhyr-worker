import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:quikhyr_worker/common/quik_colors.dart';
import 'package:quikhyr_worker/common/quik_dialogs.dart';
import 'package:quikhyr_worker/common/widgets/longIconButton.dart';
import 'package:quikhyr_worker/common/widgets/short_icon_button.dart';
import 'package:quikhyr_worker/features/auth/blocs/bloc/service_and_subservice_list_bloc.dart';
import 'package:quikhyr_worker/features/auth/presentation/components/my_text_field.dart';
import 'package:quikhyr_worker/features/chat/firebase_firestore_service.dart';
import 'package:quikhyr_worker/features/chat/firebase_provider.dart';
import 'package:quikhyr_worker/features/chat/notification_service.dart';
import 'package:quikhyr_worker/features/chat/presentation/components/chat_messages.dart';
import 'package:quikhyr_worker/features/chat/presentation/components/chat_text_field.dart';
import 'package:quikhyr_worker/models/subservices_model.dart';

import '../../../../common/quik_secure_constants.dart';

class ChatConversationScreen extends StatefulWidget {
  final String clientId;
  const ChatConversationScreen({super.key, required this.clientId});

  @override
  State<ChatConversationScreen> createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  final unitController = TextEditingController();
  final pricePerUnitController = TextEditingController();
  String? _selectedService;
  SubserviceModel? _selectedSubService;
  Map<String, List<SubserviceModel>> _serviceSubserviceMap = {};
  String subserviceId = '00';
  final NotificationsService notificationsService = NotificationsService();
  DateTime selectedDateTime = DateTime.now();

  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
      ..getClientById(widget.clientId)
      ..getMessages(widget.clientId);
    notificationsService.getReceiverToken(widget.clientId);
    _loadData();
    super.initState();
  }

  void _loadData() async {
    List<SubserviceModel> subservices = await _fetchSubservices();
    for (var subservice in subservices) {
      if (!_serviceSubserviceMap.containsKey(subservice.serviceName)) {
        _serviceSubserviceMap[subservice.serviceName] = [];
      }
      _serviceSubserviceMap[subservice.serviceName]!.add(subservice);
    }

    // Update the state to reflect the changes
    setState(() {});
  }

  Future<List<SubserviceModel>> _fetchSubservices() async {
    try {
      final response =
          await getSubservicesData(FirebaseAuth.instance.currentUser!.uid);
      final jsonResponse = jsonDecode(response);
      if (jsonResponse is! List<dynamic>) {
        throw Exception('Unexpected response format');
      }
      final subserviceModelList = jsonResponse
          .map((item) => SubserviceModel.fromJson(json.encode(item)))
          .toList();
      return subserviceModelList;
    } catch (e) {
      return [];
    }
  }

  Future<String> getSubservicesData(String workerId) async {
    try {
      final url = Uri.parse('$baseUrl/subservices?workerId=$workerId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'Failed to get subservices ${response.body}';
      }
    } catch (e) {
      return 'Failed to get subservices: $e';
    }
  }

  Future<void> _sendBooking(BuildContext context) async {
    if (unitController.text.isNotEmpty &&
        pricePerUnitController.text.isNotEmpty) {
      // final response = await BookingRepository().createBooking(
      //   BookingModel(
      //     subserviceId: _selectedSubService?.id ?? "Error while selecting subservice",
      //     location: LocationModel(latitude: 55, longitude: 55),
      //     clientId: widget.clientId,
      //     dateTime: selectedDateTime,
      //     ratePerUnit: num.parse(pricePerUnitController.text),
      //     status: "Pending",
      //     unit: unitController.text,
      //     workerId: FirebaseAuth.instance.currentUser!.uid,
      //   ),
      // );

      // // Check the result of the createBooking call
      // final isSuccess = response.fold((l) {
      //   debugPrint(l.toString());
      //   return false; // Return false if there's an error
      // }, (r) => true); // Return true if successful

      // // Only run the following methods if createBooking was successful
      // if (isSuccess) {
      //   debugPrint("Booking created successfully");

      // Add booking message to Firestore
      await FirebaseFirestoreService.addBookingMessage(
        subserviceId:
            _selectedSubService?.id ?? "Error while selecting subserviceId",
        unit: unitController.text,
        ratePerUnit: num.parse(pricePerUnitController.text),
        receiverId: widget.clientId,
        content:
            "Booking Request from ${FirebaseAuth.instance.currentUser!.uid}",
        timeslot: selectedDateTime,
      );

      // Send a notification
      await notificationsService.sendNotification(
        body: "Booking Request from ${FirebaseAuth.instance.currentUser!.uid}",
        senderId: FirebaseAuth.instance.currentUser!.uid,
      );

      // Clear the text fields
      unitController.clear();
      pricePerUnitController.clear();

      // Unfocus any focused input fields
      if (context.mounted) {
        FocusScope.of(context).unfocus();
      }
    }
  }

  Future<bool> checkHasResponded() async {
    try {
      final snapshot = await FirebaseFirestoreService.firestore
          .collection('workers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chat')
          .doc(widget.clientId)
          .collection('messages')
          .where('messageType', isEqualTo: 'booking')
          // Consider adding .limit(number) to paginate results
          .get();
      debugPrint('Snapshot: $snapshot');
      // Check if there are any documents in the snapshot
      if (snapshot.docs.isEmpty) {
        return true; // No messages found, or no response yet
      }

      // Check if 'hasResponded' field is present and true in any message
      final hasResponded =
          snapshot.docs.any((doc) => doc.data()['hasResponded'] == null);
      debugPrint('Has responded: $hasResponded');
      return hasResponded;
    } catch (e) {
      // Handle specific Firestore errors or log the exception
      debugPrint('An error occurred while checking responses: $e');
      return true; // Return false or handle the error as needed
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
              context.read<ServiceAndSubserviceListBloc>().add(
                  GetServicesAndSubservices()); // assuming this is the event to get the list of services and subservices
              showModalBottomSheet(
                scrollControlDisabledMaxHeightRatio: 0.8,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                              // enabledBorderColor: textInputBackgroundColor,
                              controller: unitController,
                              hintText: 'Enter Unit',
                              obscureText: false,
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(height: 16),
                            MyTextField(
                                // enabledBorderColor: textInputBackgroundColor,
                                controller: pricePerUnitController,
                                hintText: 'Enter Price Per Unit',
                                obscureText: false,
                                keyboardType:
                                    const TextInputType.numberWithOptions()),
                            const SizedBox(height: 16),
                            ShortIconButton(
                              width: 200,
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
                            DropdownButton<String>(
                              value: _selectedService,
                              items: _serviceSubserviceMap.keys.map((service) {
                                return DropdownMenuItem<String>(
                                  value: service,
                                  child: Text(service),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedService = value;
                                  _selectedSubService = null;
                                });
                              },
                            ),
                            if (_selectedService != null)
                              DropdownButton<SubserviceModel>(
                                
                                value: _selectedSubService,
                                items: _serviceSubserviceMap[_selectedService]!
                                    .map((subService) {
                                  return DropdownMenuItem<SubserviceModel>(
                                    
                                    value: subService,
                                    child: Text(subService.name),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedSubService = value;
                                  });
                                },
                              ),
                            const SizedBox(height: 16),
                            Text(
                              'Selected Date and Time: ${DateFormat('yyyy-MM-dd – kk:mm').format(selectedDateTime)}',
                              style: const TextStyle(
                                  color: onSecondary, fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            LongIconButton(
                              backgroundColor: textInputBackgroundColor,
                              foregroundColor: secondary,
                              onPressed: () {
                                _sendBooking(context);
                                showImmediateBookingCreationSuccessSnackBar(
                                    context);
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
