import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quikhyr_worker/common/quik_secure_constants.dart';
import 'package:quikhyr_worker/features/notification/models/work_alert_rejection_back_to_client_model.dart';
import 'package:quikhyr_worker/features/notification/models/work_approval_request_back_to_client_model.dart';
import 'package:quikhyr_worker/models/notification_model.dart';

class NotificationRepo {
  // Future<Either<String, bool>> createNotification(
  //     NotificationModel notification) async {
  //   try {
  //     final url = Uri.parse('$baseUrl/notifications');
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: notification.toJson(),
  //     );

  //     if (response.statusCode == 201) {
  //       return const Right(true);
  //     } else {
  //       log(response.body);
  //       return Left('Failed to create notification ${response.body}');
  //     }
  //   } catch (e) {
  //     return Left('Failed to create notification $e');
  //   }
  // }

  Future<Either<String, bool>> createWorkAlertRejectionBackToClient(
      WorkAlertRejectionBackToClientModel notification) async {
    try {
      debugPrint(notification.toJson());
      final url = Uri.parse('$baseUrl/notifications/work-alert-rejection');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: notification.toJson(),
      );
      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        log(response.body);
        return Left(
            'Failed to create createWorkAlertRejectionBackToClient ${response.body}');
      }
    } catch (e) {
      return Left('Failed to create createWorkAlertRejectionBackToClient $e');
    }
  }

    Future<Either<String, bool>> createWorkApprovalRequestBackToClient(
      WorkApprovalRequestBackToClientModel notification) async {
    try {
      debugPrint(notification.toJson());
      final url = Uri.parse('$baseUrl/notifications/work-approval-request');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: notification.toJson(),
      );
      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        log(response.body);
        return Left(
            'Failed to create createWorkApprovalRequestBackToClient ${response.body}');
      }
    } catch (e) {
      return Left('Failed to create createWorkApprovalRequestBackToClient $e');
    }
  }

  Future<Either<String, List<NotificationModel>>> getNotifications() async {
    try {
      final String workerId = FirebaseAuth.instance.currentUser!.uid;
      final url = Uri.parse('$baseUrl/notifications?workerId=$workerId');
      final response = await http.get(url);
      debugPrint(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> notificationsJson = jsonDecode(response.body);
        final List<NotificationModel> notifications = notificationsJson
            .map((notificationJson) =>
                NotificationModel.fromMap(notificationJson))
            .toList();
        return Right(notifications);
      } else {
        log(response.body);
        return Left('Failed to get notifications ${response.body}');
      }
    } catch (e) {
      return Left('Failed to get notifications $e');
    }
  }
}
