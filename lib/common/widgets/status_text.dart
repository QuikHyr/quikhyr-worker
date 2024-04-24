import 'package:flutter/material.dart';

import '../enums/status.dart';
import '../quik_colors.dart';
import '../quik_themes.dart';

class StatusText extends StatelessWidget {
  final Status status;
  const StatusText({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor = quikHyrBlue;
    switch (status) {
      case Status.pending:
        statusColor = quikHyrBlue;
        break;

      case Status.completed:
        statusColor = quikHyrGreen;
        break;

      case Status.notCompleted:
        statusColor = quikHyrRed;
        break;
    }
    return TextButton(
      style: ElevatedButton.styleFrom(
          side: BorderSide(
            style: BorderStyle.solid,
            color: statusColor,
          ),
          backgroundColor: textInputActiveBackgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24)),
      onPressed: null,
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: 'Status: ',
              style: bodyLargeTextStyle,
            ),
            TextSpan(
              text: status.toJson(),
              style: bodyLargeTextStyle.copyWith(color: statusColor),
            ),
          ],
        ),
      ),
    );
  }
}