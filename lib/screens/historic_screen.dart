import 'package:flutter/material.dart';
import 'package:monitor_app/models/alert_model.dart';
import 'package:provider/provider.dart';
import '../providers/monitor_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MonitorProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Alertas')),
      body: FutureBuilder<List<AlertModel>>(
        future: provider.getHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum alerta registrado ainda.'));
          }
          final alerts = snapshot.data!;
          return ListView.builder(
            itemCount: alerts.length,
            itemBuilder: (context, index) {
              final event = alerts[index];
              return ListTile(
                leading: const Icon(Icons.warning, color: Colors.red),
                title: Text(event.type),
                subtitle: Text('Data: ${event.time}'),
              );
            },
          );
        },
      ),
    );
  }
}
