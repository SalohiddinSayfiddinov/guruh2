import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize(BuildContext context) async {
    await _requestPermissions();

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        _handleForegroundNotification(context, message);
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        _handleNotificationClick(message);
      },
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    _firebaseMessaging.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message != null) {
          _handleNotificationClick(message);
        }
      },
    );
  }

  Future<void> _requestPermissions() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined permission');
    }
  }

  void _handleForegroundNotification(
      BuildContext context, RemoteMessage message) {
    print('Foreground notification received:'
        '${message.notification?.title}'
        ' ${message.notification?.body}');
    _showAlertDialog(
      context,
      message.notification?.title ?? 'Null keldi',
      message.notification?.body ?? 'bu ham null',
    );
  }

  void _showAlertDialog(BuildContext context, String title, String body) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ok'),
            ),
          ],
        );
      },
    );
  }

  void _handleNotificationClick(RemoteMessage message) {
    print('Notification clicked');
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Background notification received:'
        '${message.notification?.title}'
        ' ${message.notification?.body}');
  }
}
