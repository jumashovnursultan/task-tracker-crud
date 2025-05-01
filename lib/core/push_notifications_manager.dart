import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:go_router/go_router.dart';




final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Получение сообщения, когда приложение в фоне.
Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  _flutterLocalNotificationsPlugin.show(
    notification.hashCode,
    notification?.title,
    notification?.body,
    const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'Уведомления'),
    ),
  );
}

// Функция-обработчик для кликов по уведомлениям (должна быть топ-уровня или статической)
void _onDidReceiveNotificationResponse(
    NotificationResponse details, GoRouter? router) {
  if (details.payload != null) {
    handleMessage(jsonDecode(details.payload!), router);
  }
}

void _onDidReceiveBackgroundNotificationResponse(
    NotificationResponse details) async {
  if (details.payload != null) {
    handleMessage(jsonDecode(details.payload!), null);
  }
}

class PushNotificationsManager {
  PushNotificationsManager._(this.router, this.context);

  factory PushNotificationsManager(router, context) =>
      _instance = PushNotificationsManager._(router, context);

  static late PushNotificationsManager _instance;

  final GoRouter? router;
  final BuildContext? context;

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Function(Map<String, dynamic>)? onOrderAcceptedMessage;

  bool _initialized = false;
  String? _token;

  Future<String?> init() async {
    if (!_initialized) {
      await FlutterLocalNotificationsPlugin().cancelAll();
      FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (!kIsWeb) {
        const android = AndroidInitializationSettings('drawable/app_logo');
        final iOS = DarwinInitializationSettings();

        final platform = InitializationSettings(android: android, iOS: iOS);
        await _flutterLocalNotificationsPlugin.initialize(
          platform,
          onDidReceiveNotificationResponse: (value) {
            _onDidReceiveNotificationResponse(value, router);
          },
          onDidReceiveBackgroundNotificationResponse:
              _onDidReceiveBackgroundNotificationResponse,
        );

        

        await _firebaseMessaging.requestPermission(
          sound: true,
          alert: true,
          badge: true,
          provisional: false,
        );
      }

      _setupMessageListeners();
      _token = await _firebaseMessaging.getToken();
      print('FCM Token: $_token');
      _initialized = true;
    }

    return _token;
  }

  void _setupMessageListeners() {
    FirebaseMessaging.onMessage.listen(_onMessageReceived);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    // Проверка, было ли приложение запущено через уведомление
    _checkInitialMessage();
  }

  Future<void> _checkInitialMessage() async {
    final RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      print('App launched via notification');
      handleMessage(initialMessage.data, router);
    }
  }

  void _onMessageReceived(RemoteMessage message) {
    if (message.notification != null) {
      _showNotification(message);
    }
  }

  void _onMessageOpenedApp(RemoteMessage message) {
    print('Notification opened: ${message.data}');
  }

  void _showNotification(RemoteMessage message) {
    final notification = message.notification;
    if (notification != null && !kIsWeb) {
      _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails('channelId', 'Уведомления'),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }
}

void handleMessage(Map<String, dynamic> data, GoRouter? router) {
  if (router != null) {
    if (router.routerDelegate.currentConfiguration.fullPath == '/splash') {
      // router.go(Routes.navigation());
    }
    if (data['notification_type'] == 'news') {
      // router.push(
      //   Routes.newsDetail(),
      //   extra: int.parse(data['id']),
      // );
    } else if (data['notification_type'] == 'parcel') {
      // router.push(
      //   Routes.parcel(),
      // );
    } 
  }
}