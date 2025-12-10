import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/monitor_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MonitorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema de Monitoramento'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/history'),
            icon: const Icon(Icons.history),
            tooltip: 'Histórico',
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/preferences'),
            icon: const Icon(Icons.settings),
            tooltip: 'Configurações',
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Status: ${provider.banner ? "Ativado" : "Desativado"}',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),

              const SizedBox(height: 20),

              // CARD 1
              _smallCard(
                icon: Icons.power_settings_new,
                title: 'Status do Sistema',
                value: provider.banner ? 'ATIVO' : 'INATIVO',
                color: Colors.blueAccent,
              ),

              const SizedBox(height: 12),

              // CARD 2
              _smallCard(
                icon: Icons.warning,
                title: 'Alertas Ativos',
                value: '0',
                color: Colors.orangeAccent,
              ),

              const SizedBox(height: 12),

              // CARD 3
              _smallCard(
                icon: Icons.timeline,
                title: 'Total de Eventos',
                value: '0',
                color: Colors.green,
              ),

              const SizedBox(height: 12),

              // CARD 4
              _smallCard(
                icon: Icons.cloud,
                title: 'Conexão API',
                value: provider.apiStatus.toUpperCase(),
                color: Colors.grey.shade500,
              ),

              const SizedBox(height: 30),
              const Text(
                'Emergência',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              GestureDetector(
                onTap: () async {
                  final success = await provider.triggerAlert();
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Alerta disparado — notificação enviada.',
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Alerta disparado — houve problema na notificação (veja logs).',
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'BOTÃO DE PÂNICO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Toque para acionar',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _smallCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
