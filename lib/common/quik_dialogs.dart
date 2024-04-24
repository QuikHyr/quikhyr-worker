import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/components/my_text_field.dart';
import 'quik_colors.dart';
import 'widgets/longIconButton.dart';

void showBookingConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Are you sure you want to close the booking?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              context.pop();
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              context.pop();
            },
          ),
        ],
      );
    },
  );
}

void showReportIssueBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Report Issue',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: onSecondary),
            ),
            const SizedBox(height: 16.0),
            const MyTextField(
                hintText: 'Enter Issues faced',
                obscureText: false,
                keyboardType: TextInputType.text),
            const SizedBox(height: 16.0),
            LongIconButton(
              text: 'Submit',
              onPressed: () {
                context.pop(); // Dismiss the bottom sheet
              },
            ),
          ],
        ),
      );
    },
  );
}

// Account Creation Successfull SnackBar
void showAccountCreationSuccessSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Account created successfully'),
      backgroundColor: Colors.green,
    ),
  );
}

void showImmediateBookingCreationSuccessSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Booking created successfully'),
      backgroundColor: Colors.green,
    ),
  );
}
