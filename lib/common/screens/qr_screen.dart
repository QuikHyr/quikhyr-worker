import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../quik_asset_constants.dart';
import '../quik_colors.dart';
import '../quik_secure_constants.dart';
import '../quik_spacings.dart';
import '../quik_themes.dart';
import '../widgets/gradient_separator.dart';
import '../widgets/quik_app_bar.dart';
import '../widgets/quik_search_bar.dart';

import 'package:http/http.dart' as http;

class QrScreen extends StatefulWidget {
  final String qrData;
  final String bookingId;
  const QrScreen({super.key, required this.qrData, required this.bookingId});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> with WidgetsBindingObserver {
  Future<void> updateBookingStatus(String bookingId) async {
  final url = '${baseUrl}/bookings/$bookingId';
  final body = jsonEncode({'status': 'Completed'});  // Use jsonEncode

  try {
    final response = await http.put(Uri.parse(url),
        body: body, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 201) {
      // Success
      debugPrint('Booking status updated successfully ${response.body}');
    } else {
      // Error
      debugPrint('Failed to update booking status ${response.body}');
    }
  } catch (e) {
    // Exception
    debugPrint('Exception occurred: $e');
  }
}

  final MobileScannerController controller = MobileScannerController(
    torchEnabled: true,
    useNewCameraSelector: true,
  );

  String? scannedQr;

  @override
  Widget build(BuildContext context) {
    debugPrint("widgetData: ${widget.qrData}");
    return Scaffold(
      appBar: const QuikAppBar(
        showBackButton: true,
        pageName: 'Book',
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: MobileScanner(
            controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.noDuplicates),
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                debugPrint('Barcode Found! ${barcode.rawValue}');
                if (barcode.rawValue == widget.qrData) {
                  MobileScannerController().stop();
                  updateBookingStatus(widget.bookingId);
                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'QR Code Scanned Successfully, Work Completed',
                        style: TextStyle(color: secondary),
                      ),
                      backgroundColor: quikHyrGreen,
                    ),
                  );
                }
              }
            }),
      ),
    );
  }
}
