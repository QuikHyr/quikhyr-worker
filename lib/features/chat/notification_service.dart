import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:quikhyr_worker/common/quik_routes.dart';


const channel = AndroidNotificationChannel(
    'high_importance_channel',
    'Hign Importance Notifications',
    description:
        'This channel is used for important notifications.',
    importance: Importance.high,
    playSound: true);

class NotificationsService {
  static const key =
      'AAAAkTLRTRc:APA91bFxWxSHRNz727vGSWXat7DKWqoDHE8e7ph9yh0E2HFnLKGNcSZ5zJjsCZB_HbiPG2U2ZEYGnpj0-Ue0AvRygt-SZ4ncmcCNe1LlsfmduDUQYc51m-P7Ro_FLG8iKmW4Rw9uLEMT';

  final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void _initLocalNotification() {
    const androidSettings = AndroidInitializationSettings(
        '@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true,
    );

    const initializationSettings = InitializationSettings(
        android: androidSettings, iOS: iosSettings);
    flutterLocalNotificationsPlugin
        .initialize(initializationSettings,
            onDidReceiveNotificationResponse: (response) {
      debugPrint(response.payload.toString());
    });
  }

  Future<void> _showLocalNotification(
      RemoteMessage message) async {
    final styleInformation = BigTextStyleInformation(
      message.notification!.body.toString(),
      htmlFormatBigText: true,
      contentTitle: message.notification!.title,
      htmlFormatTitle: true,
    );
    final androidDetails = AndroidNotificationDetails(
      'com.example.chat_app.urgent',
      'mychannelid',
      importance: Importance.max,
      styleInformation: styleInformation,
      priority: Priority.max,
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    await flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['body']);
  }

  Future<void> requestPermission() async {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint(
          'User declined or has not accepted permission');
    }
  }

  Future<void> getToken() async {
    final token =
        await FirebaseMessaging.instance.getToken();
    _saveToken(token!);
  }

  Future<void> _saveToken(String token) async =>
      await FirebaseFirestore.instance
          .collection('workers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'fcmToken': token}, SetOptions(merge: true));

  String receiverToken = '';

  Future<void> getReceiverToken(String? receiverId) async {
    final getToken = await FirebaseFirestore.instance
        .collection('clients')
        .doc(receiverId)
        .get();

    receiverToken = await getToken.data()!['fcmToken'];
  }

  void firebaseNotification(context) async{
    _initLocalNotification();

    FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage message) async{
      // await Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (_) =>
      //         ChatConversationScreen(clientId: message.data['senderId']),
      //   ),
      // );
      GoRouter.of(context).goNamed(QuikRoutes.chatConversationName, pathParameters: {'clientId': message.data['senderId']});
    });

    FirebaseMessaging.onMessage
        .listen((RemoteMessage message) async {
      await _showLocalNotification(message);
    });
  }

  Future<void> sendNotification(
      {required String body,
      required String senderId}) async {
    try {
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$key',
        },
        body: jsonEncode(<String, dynamic>{
          "to": receiverToken,
          'priority': 'high',
          'notification': <String, dynamic>{
            'body': body,
            'title': 'New Message !',
          },
          'data': <String, String>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': 'done',
            'senderId': senderId,
          }
        }),
      );
      debugPrint(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
