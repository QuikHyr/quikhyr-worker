import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:quikhyr_worker/common/quik_secure_constants.dart';
import 'package:quikhyr_worker/models/notification_model.dart';

class NotificationRepo {
  Future<Either<String, bool>> createNotification(NotificationModel notification) async {
try {
    final url = Uri.parse('$baseUrl/notifications');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: notification.toJson(),
  );

  if (response.statusCode == 201) {
    return const Right(true);
  } else {
    log(response.body);
    return Left('Failed to create notification ${response.body}');
  }
} catch (e) {
  return Left('Failed to create notification $e');
}
}
}
