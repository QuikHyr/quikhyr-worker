// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:quikhyr_worker/common/quik_asset_constants.dart';
// import 'package:quikhyr_worker/models/notification_model.dart';

// import '../enums/status.dart';
// import '../quik_colors.dart';
// import '../quik_spacings.dart';
// import '../quik_themes.dart';

// class QuikNotificationListTile extends StatelessWidget {
//   NotificationModel notification;
//   QuikNotificationListTile({
//     Key? key,
//     required this.notification,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       leading: Container(
//         height: 48,
//         width: 48,
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(color: primary),
//         ),
//         child: SvgPicture.network(
//           QuikAssetConstants.plumbingSvg,
//           height: 24,
//           width: 24,
//         ),
//       ),
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(notification., style: workerListNameTextStyle),
//           QuikSpacing.vS8(),
//           Text(notification.serviceName, style: chatSubTitle),
//         ],
//       ),
//       subtitle: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           QuikSpacing.vS8(),
//           if (notification.status == Status.notCompleted)
//             Text(
//                 '${notification.dateTime.hour}:${notification.dateTime.minute} ${notification.dateTime.hour >= 12 ? 'PM' : 'AM'} ${notification.dateTime.toString().split(" ")[0]}',
//                 style: timeGreenTextStyle.copyWith(color: quikHyrRed))
//           else
//             Text(
//                 '${notification.dateTime.hour}:${notification.dateTime.minute} ${notification.dateTime.hour >= 12 ? 'PM' : 'AM'} ${notification.dateTime.toString().split(" ")[0]}',
//                 style: timeGreenTextStyle)
//         ],
//       ),
//       trailing: ,
//     );
//   }
// }
