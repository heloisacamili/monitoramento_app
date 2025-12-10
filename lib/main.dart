import 'package:flutter/material.dart';
import 'package:monitor_app/app/app.dart';
import 'package:monitor_app/services/notifications_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(const MonitorApp());
}
