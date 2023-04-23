import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationsService {
  Future<void> sendChatMessage(String message, String receiverId) async {
    DocumentSnapshot<Map<String, dynamic>> recipientSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(receiverId)
            .get();
    print(recipientSnapshot.data());
    await _sendChatNotification(message, recipientSnapshot.data()!["token"]);
    print("work");
  }

  Future<void> _sendChatNotification(
      String message, String recipientToken) async {
   
    await FirebaseMessaging.instance.sendMessage(to: recipientToken, data: {
      'message': message,
      'recipientToken': recipientToken,
    });
  }

  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
  static Future _notificationsDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
          'your channel id', 'your channel name',
          importance: Importance.max),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    const ios = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");
    await _notifications.initialize(
        const InitializationSettings(android: android, iOS: ios),
        onSelectNotification: (payload) async =>
            {onNotifications.add(payload)});
  }

  static void show(
          {int id = 0, String? title, String? body, String? payload}) async =>
      _notifications.show(id, title, body, await _notificationsDetails());

  static void showScheduledNotifcation({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async {
    await _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local)
            .add(const Duration(seconds: 5)),
        await _notificationsDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  void cancelNotification(int id) async {
    await _notifications.cancel(id);
  }
}
