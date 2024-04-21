import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';

// class Schedule {
//   String details;
//   DateTime time;

// }

Future<void> createReminderMorning() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: DateTime.now().microsecondsSinceEpoch.remainder(1000000),
      channelKey: "app_channel",
      title: '🙏🙏 It\'s time to pray ',
      body:
          '🙏 Time to Pray! Take a moment now to connect with the Divine. Your prayers matter. 🌟 ',
      notificationLayout: NotificationLayout.Default,
    ),
    // actionButtons: [
    //   NotificationActionButton(key: "Mark_Done", label: "Mark Done"),
    // ],
    // schedule: NotificationCalendar(
    //   repeats: true,
    //   // weekday: [1,2],
    //   hour: 07,
    //   minute: 00,
    //   second: 0,
    //   millisecond: 0,
    // ),
  );
}

// Future<void> createReminderNoon() async {
//   await AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: DateTime.now().microsecondsSinceEpoch.remainder(1000000),
//       channelKey: "scheduled_channel",
//       title: '🙏 It\'s time to pray ',
//       body:
//           'Time to Pray! Take a moment now to connect with the Divine. Your prayers matter. 🌟 ',
//       notificationLayout: NotificationLayout.Default,
//     ),
//     // actionButtons: [
//     //   NotificationActionButton(key: "Mark_Done", label: "Mark Done"),
//     // ],
//     schedule: NotificationCalendar(
//       repeats: true,
//       // weekday: [1,2],
//       hour: 12,
//       minute: 40,
//       second: 0,
//       millisecond: 0,
//     ),
//   );
// }
