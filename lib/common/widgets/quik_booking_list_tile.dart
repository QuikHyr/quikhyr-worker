import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../models/booking_model.dart';
import '../enums/status.dart';
import '../quik_asset_constants.dart';
import '../quik_colors.dart';
import '../quik_routes.dart';
import '../quik_spacings.dart';
import '../quik_themes.dart';
import 'clickable_svg_icon.dart';

class QuikBookingListTile extends StatelessWidget {
  const QuikBookingListTile({
    super.key,
    required this.booking,
  });

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: gridItemBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 8),
        leading: Container(
          height: 48,
          width: 48,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: primary),
          ),
          child: SvgPicture.network(
            booking.serviceAvatar,
            height: 24,
            width: 24,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(booking.workerName,
                style: workerListNameTextStyle),
            QuikSpacing.vS8(),
            Text(booking.serviceName,
                style: chatSubTitle),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuikSpacing.vS8(),
            if (booking.status == Status.notCompleted)
              Text(
                  '${booking.dateTime.hour}:${booking.dateTime.minute} ${booking.dateTime.hour >= 12 ? 'PM' : 'AM'} ${booking.dateTime.toString().split(" ")[0]}',
                  style: timeGreenTextStyle.copyWith(
                      color: quikHyrRed))
            else
              Text(
                  '${booking.dateTime.hour}:${booking.dateTime.minute} ${booking.dateTime.hour >= 12 ? 'PM' : 'AM'} ${booking.dateTime.toString().split(" ")[0]}',
                  style: timeGreenTextStyle)
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClickableSvgIcon(
                svgAsset: QuikAssetConstants.qrCodeSvg,
                height: 32,
                width: 32,
                onTap: () {
                  context.pushNamed(
                      QuikRoutes.bookingQrName,
                      pathParameters: {
                        "qrData":
                            booking.id.hashCode.toString()
                      });
                }),
            QuikSpacing.hS12(),
            ClickableSvgIcon(
                svgAsset:
                    QuikAssetConstants.arrowRightUpSvg,
                height: 32,
                width: 32,
                onTap: () {
                  context.goNamed(
                      QuikRoutes.bookingDetailName,
                      extra: booking);
                }),
          ],
        ),
      ),
    );
  }
}