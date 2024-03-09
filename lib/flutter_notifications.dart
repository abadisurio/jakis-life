import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

bool isFlutterLocalNotificationsInitialized = false;

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: "Used for important notifications for Jaki's Life.",
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  const initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');

  const initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    // iOS: initializationSettingsDarwin,
    // macOS: initializationSettingsDarwin,
    // linux: initializationSettingsLinux,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          selectNotificationStream.add(notificationResponse.payload);

        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.actionId == navigationActionId) {
            selectNotificationStream.add(notificationResponse.payload);
          }
      }
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

  /// Receive a notification when the app is in the background
  /// and terminated (in Android)
  FirebaseMessaging.onBackgroundMessage(
    _firebaseMessagingOnBackgroundReceive,
  );

  /// Receive a notification when the app is in the foreground
  FirebaseMessaging.onMessage.listen((remoteMessage) {
    log('remoteMessage onMessage $remoteMessage');
    showFlutterNotification(remoteMessage);
  });

  /// Open apps with remote message when app is opened
  /// and running in the background but not terminated
  FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
    log('remoteMessage onMessageOpenedApp $remoteMessage');
    showFlutterNotification(remoteMessage);
  });

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  final notification = message.notification;
  final android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'mipmap/ic_launcher',
        ),
      ),
    );
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
      'notification action tapped with input: ${notificationResponse.input}',
    );
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingOnBackgroundReceive(
  RemoteMessage remoteMessage,
) async {
  log('remoteMessage onBackgroundReceive $remoteMessage');
  showFlutterNotification(remoteMessage);
  // final prefs = await SharedPreferences.getInstance();
  // final env = Environment.values.elementAt(prefs.getInt('env') ?? 0);
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform(env),
  // );
  // final data = remoteMessage.data;
  // final analyticsLabel = data['analytics_label'] as String?;
  // if (remoteMessage.data['route_name'] != null) {
  //   await prefs.setString(
  //     SharedPreferenceKey.redirectRoute,
  //     remoteMessage.data['route_name'].toString(),
  //   );
  // }

  // // Prevent analytics called within dev env
  // if (env != Environment.development) {
  //   await Amplitude.getInstance().init(AnalyticsConstants.amplitudeKey);
  //   try {
  //     if (analyticsLabel != null) {
  //       await AnalyticsUtil.trackEvent(
  //         AnalyticsConstants.evNotificationBackgroundReceiveCustom,
  //         {
  //           AnalyticsConstants.epMessage: analyticsLabel,
  //         },
  //       );
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
