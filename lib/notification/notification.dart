import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;

import '../controllers/langauge_controller.dart';

var _languageController = Get.find<LocalizationController>();

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveNotification(
      NotificationResponse notificationResponse) async {
    print("Notification receive");
  }

  static Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const DarwinInitializationSettings iOSInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotification,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> showInstantNotification(String title, String body) async {
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: AndroidNotificationDetails(
          'instant_notification_channel_id',
          'Instant Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails());

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'instant_notification',
    );
  }

  static Future<void> scheduleDailyNotificationAt8AM() async {
    // Get today's date and set the time for 8:00 AM
    final DateTime now = DateTime.now();
    DateTime scheduledTime = DateTime(now.year, now.month, now.day, 12, 00);

    // If it's already past 8:00 AM today, schedule for tomorrow
    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(Duration(days: 1));
    }

    // Schedule the notification using a daily repeating interval
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // Notification ID
      "It's time to pray the Rosary", // Notification Title
      "Take a moment for peace and reflection as you meditate on the mysteries of the Rosary.",
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_notifications_channel', // Your channel ID
          'Daily Notifications', // Channel name
          channelDescription: 'This channel is for daily notifications',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents:
          DateTimeComponents.time, // Repeats daily at the set time
    );
  }

  // static Future<void> scheduleNotificationb(DateTime scheduledTime) async {
  //   // Fixed notification details
  //   const int id = 0; // Notification ID
  //   String title = "reminder_title".tr; // Notification title
  //   String body = "reminder_desc".tr; // Notification body

  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     id,
  //     title,
  //     body,
  //     tz.TZDateTime.from(scheduledTime, tz.local),
  //     const NotificationDetails(
  //       iOS: DarwinNotificationDetails(),
  //       android: AndroidNotificationDetails(
  //         'reminder_channel',
  //         'Reminder Channel',
  //         importance: Importance.high,
  //         priority: Priority.high,
  //       ),
  //     ),
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //     androidAllowWhileIdle: true,
  //     matchDateTimeComponents: DateTimeComponents.time, // Daily notification
  //   );
  // }
}