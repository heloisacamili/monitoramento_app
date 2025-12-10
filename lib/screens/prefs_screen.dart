import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/monitor_provider.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MonitorProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Preferências')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Vibração'),
            value: provider.vibration,
            onChanged: (v) {
              provider.vibration = v;
              provider.savePreferences();
            },
          ),
          SwitchListTile(
            title: const Text('Som'),
            value: provider.sound,
            onChanged: (v) {
              provider.sound = v;
              provider.savePreferences();
            },
          ),
          SwitchListTile(
            title: const Text('Banner'),
            value: provider.banner,
            onChanged: (v) {
              provider.banner = v;
              provider.savePreferences();
            },
          ),
        ],
      ),
    );
  }
}
