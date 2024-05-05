import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quikhyr_worker/common/quik_asset_constants.dart';
import 'package:quikhyr_worker/common/quik_routes.dart';
import 'package:quikhyr_worker/common/quik_themes.dart';
import 'package:quikhyr_worker/common/utils/format_date.dart';
import 'package:quikhyr_worker/common/widgets/quik_app_bar.dart';
import 'package:quikhyr_worker/features/notification/cubit/notification_cubit.dart';

import '../../../common/quik_colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    context.read<NotificationCubit>().getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const QuikAppBar(
        showBackButton: true,
        pageName: 'Notifications',
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotificationLoaded) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: ListView.builder(
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  final notification = state.notifications[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      height: 48,
                      width: 48,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: primary,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        color: onSecondary,
                        QuikAssetConstants.plumbingSvg,
                        height: 24,
                        width: 24,
                      ),
                    ),
                    title: Text(
                        notification.type?.notificationListTileDisplayString ??
                            "Notification Category",
                        style: Theme.of(context).textTheme.headlineSmall),
                    subtitle: Text(
                        notification.description ?? "Notification Description",
                        style: chatSubTitle),
                    trailing: Text(
                      formatDate(
                          notification.timestamps?.updatedAt.toDateTime() ??
                              DateTime.now()),
                      style: chatTrailingActive,
                    ),
                    onTap: () {
                      context.pushNamed(QuikRoutes.notificationDetailName,
                          extra: notification);
                      // showModalBottomSheet(
                      //     barrierColor: Colors.black,
                      //     backgroundColor: Colors.black,
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return Container(
                      //         height: 200,
                      //         color: Theme.of(context).colorScheme.secondary,
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(12.0),
                      //           child: Column(
                      //             children: [
                      //               Text(
                      //                 notification.type
                      //                         ?.notificationListTileDisplayString ??
                      //                     "Notification Category",
                      //                 style: Theme.of(context)
                      //                     .textTheme
                      //                     .titleMedium,
                      //               ),
                      //               QuikSpacing.vS24(),
                      //               Text(notification.description),
                      //               Row(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.spaceEvenly,
                      //                 children: [
                      //                   ElevatedButton(
                      //                     onPressed: () {
                      //                       debugPrint("Accepted");
                      //                     },
                      //                     child: const Text("Accept"),
                      //                   ),
                      //                   ElevatedButton(
                      //                     onPressed: () {
                      //                       debugPrint("Rejected");
                      //                     },
                      //                     child: const Text("Reject"),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       );
                      //     });
                    },
                  );
                },
              ),
            );
          } else if (state is NotificationError) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: Text("Unknown Error"));
          }
        },
      ),
    );
  }
}
