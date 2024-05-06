import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:quikhyr_worker/common/enums/status.dart';
import 'package:quikhyr_worker/common/quik_colors.dart';
import 'package:quikhyr_worker/common/quik_routes.dart';
import 'package:quikhyr_worker/common/widgets/clickable_svg_icon.dart';
import 'package:quikhyr_worker/common/widgets/quik_app_bar.dart';

import '../../../../common/quik_asset_constants.dart';
import '../../../../common/quik_dialogs.dart';
import '../../../../common/quik_spacings.dart';
import '../../../../common/quik_themes.dart';
import '../../../../common/widgets/gradient_separator.dart';
import '../../../../common/widgets/quik_list_tile_button_and_text.dart';
import '../../../../common/widgets/quik_short_button.dart';
import '../../../../common/widgets/status_text.dart';
import '../../../../models/booking_model.dart';


class BookingDetailScreen extends StatelessWidget {
  final Booking booking;
  const BookingDetailScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: QuikAppBar(
          title: booking.workerName,
          subtitle: booking.serviceName,
          showPageName: false,
          hasCircleBorder: true,
          circleBorderColor:
              booking.status == Status.pending ? primary : labelColor,
          leadingSvgLink: booking.serviceAvatar,
          showBackButton: true,
          trailingWidgets: [
            if (booking.status == Status.notCompleted)
              ClickableSvgIcon(
                  svgAsset: QuikAssetConstants.qrCodeSvg,
                  height: 32,
                  width: 32,
                  onTap: () {
                    context.pushNamed(QuikRoutes.bookingQrName,
                        pathParameters: {
                          "qrData": booking.id.hashCode.toString(), "bookingId": booking.id ?? "-00"
                        });
                  })
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GradientSeparator(
                  paddingTop: 0,
                ),
                QuikSpacing.vS12(),
                Text("OVERVIEW",
                    style: Theme.of(context).textTheme.titleMedium),
                QuikSpacing.vS24(),
                const Text(
                  "Get a complete overview of the booking you have made.",
                  style: descriptionTextStyle,
                ),
                QuikSpacing.vS32(),
                RichText(
                  text: TextSpan(
                    text: "Time Slot: ",
                    style: bodyLargeTextStyle,
                    children: [
                      if (booking.status == Status.pending)
                        TextSpan(
                          text: DateFormat('hh:mm a').format(booking.dateTime),
                          style: bodyLargeBoldTextStyle.copyWith(
                              color: quikHyrGreen),
                        )
                      else
                        TextSpan(
                          text: DateFormat('hh:mm a').format(booking.dateTime),
                          style: bodyLargeBoldTextStyle,
                        )
                    ],
                  ),
                ),
                QuikSpacing.vS16(),
                RichText(
                  text: TextSpan(
                    text: "Work Rate: ",
                    style: bodyLargeTextStyle,
                    children: [
                      TextSpan(
                        text: '${booking.ratePerUnit} /${booking.unit}',
                        style: bodyLargeBoldTextStyle,
                      ),
                    ],
                  ),
                ),
                QuikSpacing.vS32(),
                StatusText(status: booking.status),
                QuikSpacing.vS32(),
                if (booking.status == Status.notCompleted)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      QuikShortButton(
                          backgroundColor: secondary,
                          foregroundColor: onSecondary,
                          onPressed: () {
                            showReportIssueBottomSheet(context);
                          },
                          text: "Report Issue",
                          svgPath: QuikAssetConstants.dangerTriangleSvg),
                      QuikSpacing.hS16(),
                      QuikShortButton(
                        onPressed: () {
                          showBookingConfirmationDialog(context);
                        },
                        text: "Close Booking",
                      ),
                    ],
                  ),
                QuikSpacing.vS32(),
                const Text("Steps to follow:", style: workerListNameTextStyle),
                QuikSpacing.vS20(),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: RichText(
                    text: const TextSpan(
                      text: "1. Provide the QR Code",
                      style: workerListNameTextStyle,
                      children: [
                        TextSpan(
                          text:
                              "  associated with your Booking ID (available by clicking on the icon at the top-right corner of the screen) to the worker,",
                          style: infoText_14_400TextStyle,
                        ),
                        TextSpan(text: " to record work completion.")
                      ],
                    ),
                  ),
                ),
                QuikSpacing.vS16(),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: RichText(
                    text: const TextSpan(
                      text: "2. Rate and review",
                      style: workerListNameTextStyle,
                      children: [
                        TextSpan(
                          text: "   the worker, which may be helpful for many.",
                          style: infoText_14_400TextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                QuikSpacing.vS24(),
                if (booking.status != Status.completed)
                  const QuikListTileButtonAndText(
                    title: "Cancel Booking",
                    leadingSvgLink: QuikAssetConstants.cancelBookingSvg,
                  ),
                const Text(
                  "Booking cancellation only available before a cut-off time of 1hr before the alloted slot.",
                  style: descriptionTextStyle,
                ),
                QuikSpacing.vS24(),
                const QuikListTileButtonAndText(
                    title: "Download booking details",
                    leadingSvgLink: QuikAssetConstants.downloadSvg),
                const Text(
                  "Booking was made on 09/03/2024 at 09:30pm via QuikHyr App.",
                  style: descriptionTextStyle,
                )
              ],
            ),
          ),
        ));
  }
}
