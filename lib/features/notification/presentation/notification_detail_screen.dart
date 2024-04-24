import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quikhyr_worker/common/quik_colors.dart';
import 'package:quikhyr_worker/common/quik_spacings.dart';
import 'package:quikhyr_worker/common/quik_themes.dart';
import 'package:quikhyr_worker/common/widgets/gradient_separator.dart';
import 'package:quikhyr_worker/common/widgets/quik_app_bar.dart';
import 'package:quikhyr_worker/common/widgets/quik_short_button.dart';

import '../../../models/notification_model.dart';
import '../cubit/notification_cubit.dart';

class NotificationDetailScreen extends StatelessWidget {
  final NotificationModel notification;
  const NotificationDetailScreen({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          final NotificationModel rejectionNotification =
                              NotificationModel(
                            senderId: FirebaseAuth.instance.currentUser!.uid,
                            receiverIds: receiverIdsWithoutCurrentWorker,
                            type: notification.type,
                            workAlertId: notification.workAlertId,
                          );
                          context
                              .read<NotificationCubit>()
                              .sendWorkAlertRejectionBackToClient(
                                  rejectionNotification);
                          context.read<NotificationCubit>().getNotifications();

                          Navigator.of(context).pop();
                        },
                      ),
                      QuikShortButton(
                        paddingHorizontal: 50,
                        paddingVertical: 20,
                        text: "Accept",
                        onPressed: () {
                          Navigator.of(context).pop();
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
