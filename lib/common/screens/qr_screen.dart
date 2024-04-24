import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../quik_asset_constants.dart';
import '../quik_colors.dart';
import '../quik_spacings.dart';
import '../quik_themes.dart';
import '../widgets/gradient_separator.dart';
import '../widgets/quik_app_bar.dart';
import '../widgets/quik_search_bar.dart';


class QrScreen extends StatelessWidget {
  final String qrData;
  const QrScreen({super.key, required this.qrData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuikAppBar(
        showBackButton: true,
        pageName: 'Book',
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QuikSearchBar(
              controller: TextEditingController(),
              onMicPressed: () {},
              onChanged: (p0) {},
              hintText: 'Search for bookings..',
              onSearch: (value) {
                // context.read<SearchBloc>().add(SearchService(value));
              },
            ),
            QuikSpacing.vS36(),
            const GradientSeparator(),
            QuikSpacing.vS24(),
            Text(
              "SCAN QR CODE",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            QuikSpacing.vS32(),
            const Text(
              "Show this QR Code to the worker, after the work has been completed.",
              style: chatSubTitleRead,
            ),
            QuikSpacing.vS32(),
            Container(
              decoration: BoxDecoration(
                color: secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: PrettyQrView(
                decoration: const PrettyQrDecoration(
                    image: PrettyQrDecorationImage(
                        scale: 0.3,
                        image: AssetImage(
                            QuikAssetConstants.logoIconCircleTransparentPng)),
                    background: secondary,
                    shape: PrettyQrSmoothSymbol(roundFactor: 0.7)),
                qrImage: QrImage(QrCode.fromData(
                    data: qrData, errorCorrectLevel: QrErrorCorrectLevel.H)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
