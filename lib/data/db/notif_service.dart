import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// Initialize the notification service
  static Future<void> initialize() async {
    // Request permissions for iOS
    await _firebaseMessaging.requestPermission();

    // Initialize Awesome Notifications
    AwesomeNotifications().initialize(
      null, // Default icon
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Chat Notifications',
          channelDescription: 'Notification channel for chat messages',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.High,
        ),
      ],
    );

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        debugPrint("This was the notification: ${message.notification!.title}");
        _showNotification(message.notification!);
      }
    });

    // Handle background and terminated state messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  /// Background message handler
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    if (message.notification != null) {
      debugPrint("This was the notification: ${message.notification!.title}");
      _showNotification(message.notification!);
    }
  }

  /// Show notification using Awesome Notifications
  static Future<void> _showNotification(RemoteNotification notification) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        channelKey: 'basic_channel',
        title: notification.title ?? 'New Message',
        body: notification.body ?? 'You have received a new message',
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }
}

