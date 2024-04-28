import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr_worker/common/enums/work_alert_type.dart';
import 'package:quikhyr_worker/common/quik_colors.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';
import 'package:quikhyr_worker/common/quik_themes.dart';
import 'package:quikhyr_worker/common/widgets/gradient_separator.dart';
import 'package:quikhyr_worker/common/widgets/quik_app_bar.dart';
import 'package:quikhyr_worker/common/widgets/quik_short_button.dart';
import 'package:quikhyr_worker/features/notification/models/work_alert_rejection_back_to_client_model.dart';
import 'package:quikhyr_worker/features/notification/models/work_approval_request_back_to_client_model.dart';

import '../../../models/location_model.dart';
import '../../../models/notification_model.dart';
import '../../auth/presentation/components/my_text_field.dart';
import '../cubit/notification_cubit.dart';

class NotificationDetailScreen extends StatelessWidget {
  final NotificationModel notification;
  const NotificationDetailScreen({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController unitController = TextEditingController();
    final TextEditingController pricePerUnitController =
        TextEditingController();
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: QuikAppBar(
          onlyHasTitle: true,
          showBackButton: true,
          showPageName: false,
          title: notification.type?.notificationListTileDisplayString ??
              "Notification Category",
        ),
        body: BlocListener<NotificationCubit, NotificationState>(
          listener: (context, state) {
            if (state is NotificationSentSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Notification sent successfully"),
                ),
              );
            }
            // context.pop();
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GradientSeparator(),
                  QuikSpacing.vS24(),
                  Text(
                      notification.type?.notificationListTileDisplayString
                              .toUpperCase() ??
                          "Notification Category",
                      style: Theme.of(context).textTheme.headlineSmall),
                  QuikSpacing.vS24(),
                  Text(
                    notification.description ?? "Notification Description",
                    style: descriptionTextStyle,
                  ),
                  QuikSpacing.vS32(),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      QuikShortButton(
                        paddingHorizontal: 50,
                        paddingVertical: 20,
                        backgroundColor: secondary,
                        foregroundColor: onSecondary,
                        text: "Reject",
                        onPressed: () {
                          /*
                                {
                                  "senderId": "9q9aXOqDbcPFn2ufunUydOmIhMk2",
                                    "receiverIds":["6C51kpTM2egYtnNhb46wyLWCsqa2","AK2vJ4tIRTdsYM8QH3k4rT6BSv33","TrpACNJ1i3PckhxiLFGAeuTPrZz2","pMUStq3gXcc1kKDivhUMZsZa1nA2","wdWKX0vPjIS8iNpETjDt82fGdh13"],
                                    "workAlertId":"x434PqGSuncVuNVibQmk",
                                    "type":"work-alert"
                                }
                                */
                          final List<String>? receiverIdsWithoutCurrentWorker =
                              notification.receiverIds
                                  ?.where((id) =>
                                      id !=
                                      FirebaseAuth.instance.currentUser!.uid)
                                  .toList();
                          final WorkAlertRejectionBackToClientModel rejectionNotification =
                              WorkAlertRejectionBackToClientModel(
                            senderId: FirebaseAuth.instance.currentUser!.uid,
                            receiverIds: receiverIdsWithoutCurrentWorker ?? [],
                            type: notification.type ?? WorkAlertType.general,
                            workAlertId: notification.workAlertId ?? "WORK ALERT ID NOT FOUND",
                          );
                          context
                              .read<NotificationCubit>()
                              .sendWorkAlertRejectionBackToClient(
                                  rejectionNotification);
                          context.read<NotificationCubit>().getNotifications();

                          // context.pop();
                        },
                      ),
                      QuikShortButton(
                        paddingHorizontal: 50,
                        paddingVertical: 20,
                        text: "Accept",
                        onPressed: () {
                          /*
                          {"senderId":"9q9aXOqDbcPFn2ufunUydOmIhMk2",
                          "receiverIds":["oBZYUrXvfCgdTS1lm7vK4f7EXft2"],
                          "workAlertId":"09SO5YNRPqMIWekfUE4Q",
                          "description":"heater","location":{"latitude":0,"longitude":0}, 
                          "locationName": "Location Not Found","subserviceId":"gKfDXlClIK00wVOJNdUB",
                          "dateTime": "2024-04-24T21:20:34.068381",
                          "ratePerUnit":100, "unit": "heater"}
                           */

                          /*MyTextField(
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
                                    const TextInputType.numberWithOptions()),*/
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
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
                                          keyboardType: const TextInputType
                                              .numberWithOptions()),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          QuikShortButton(
                                            foregroundColor: primary,
                                            backgroundColor: secondary,
                                            text: 'Submit',
                                            onPressed: () {
                                              final WorkApprovalRequestBackToClientModel
                                                  requestNotification =
                                                  WorkApprovalRequestBackToClientModel(
                                                unit: unitController.text,
                                                ratePerUnit: double.parse(
                                                    pricePerUnitController
                                                        .text),
                                                senderId: FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                receiverIds: [
                                                  notification.senderId ??
                                                      "SENDER ID NOT FOUND"
                                                ],
                                                description:
                                                    notification.description ?? "DESCRIPTION NOT FOUND",
                                                subserviceId:
                                                    notification.subserviceId ?? "SUBSERVICE ID NOT FOUND",
                                                dateTime: DateTime.now(),
                                                location: notification.location ?? LocationModel(latitude: 50, longitude: 50),
                                                locationName:
                                                    notification.locationName ?? "LOCATION NAME NOT FOUND",
                                                workAlertId:
                                                    notification.workAlertId ?? "WORK ALERT ID NOT FOUND",
                                              );
                                              context
                                                  .read<NotificationCubit>()
                                                  .sendWorkApprovalRequestBackToClient(
                                                      requestNotification);
                                              context
                                                  .read<NotificationCubit>()
                                                  .getNotifications();
                                            },
                                          ),
                                          QuikShortButton(
                                            backgroundColor:
                                                gridItemBackgroundColor,
                                            text: "Cancel",
                                            onPressed: () {
                                              context.pop();
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              });
                          //Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  QuikSpacing.vS12(),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Accept or reject the work approval request",
                      style: descriptionTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
