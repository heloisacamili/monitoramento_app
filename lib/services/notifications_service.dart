import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  static const String channelId = 'basic_channel';
  static const String channelName = 'Alertas';

  Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    final settings = InitializationSettings(android: androidInit, iOS: iosInit);

    await _plugin.initialize(settings);
    
    const androidChannel = AndroidNotificationChannel(
      channelId,
      channelName,
      importance: Importance.max,
    );
    try {
      await _plugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidChannel);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> showBasic(String title, String body) async {
    try {
      const android = AndroidNotificationDetails(
        channelId,
        channelName,
        importance: Importance.max,
        priority: Priority.high,
      );
      const details = NotificationDetails(android: android);
      await _plugin.show(DateTime.now().millisecondsSinceEpoch ~/ 1000, title, body, details);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
