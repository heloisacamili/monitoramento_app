import 'package:flutter/material.dart';
import 'package:monitor_app/providers/monitor_provider.dart';
import 'package:monitor_app/screens/dashboard_screen.dart';
import 'package:monitor_app/screens/historic_screen.dart';
import 'package:monitor_app/screens/prefs_screen.dart';
import 'package:provider/provider.dart';

class MonitorApp extends StatelessWidget {
  const MonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MonitorProvider()..loadPreferences(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (_) => const DashboardScreen(),
          '/preferences': (_) => const PreferencesScreen(),
          '/history': (_) => const HistoryScreen(),
        },
      ),
    );
  }
}