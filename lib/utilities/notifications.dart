import 'package:flutter_local_notifications/flutter_local_notifications.dart' show AndroidNotificationDetails, FlutterLocalNotificationsPlugin, IOSNotificationDetails, NotificationDetails, Time;

Future enableNotification(Time time) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      const AndroidNotificationDetails(
    '0',
    'Сбор рюкзака',
    'remindAboutPackBag',
    // enableVibration: true,
    // enableLights: true,
    // playSound: true,
    // visibility: NotificationVisibility.Public,
  );
  IOSNotificationDetails iOSPlatformChannelSpecifics = const IOSNotificationDetails();
  NotificationDetails platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.showDailyAtTime(
    0,
    'show daily title',
    'Daily notification shown at approximately',
    time,
    platformChannelSpecifics,
  );
}
