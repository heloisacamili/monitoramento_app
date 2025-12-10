import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:monitor_app/models/alert_model.dart';
import 'package:monitor_app/services/notifications_service.dart';
import '../services/preferences_service.dart';
import '../services/sqlite_service.dart';

class MonitorProvider extends ChangeNotifier {
  bool vibration = true;
  bool sound = true;
  bool banner = true;
  String apiStatus = 'Carregando...';

  final _prefs = PreferencesService();
  final _db = SqliteService.instance;

  Future<void> loadPreferences() async {
    final p = await _prefs.load();
    vibration = p['vibration']!;
    sound = p['sound']!;
    banner = p['banner']!;
    fetchApiStatus();
    notifyListeners();
  }

  Future<void> savePreferences() async {
    await _prefs.save(vibration: vibration, sound: sound, banner: banner);
    notifyListeners();
  }

  /// Retorna true se tudo ocorreu ok (inserção + notificação)
  Future<bool> triggerAlert() async {
    try {
      final time = DateTime.now().toIso8601String();
      final event = AlertModel(type: 'Alerta', time: time);
      await _db.insert(event);

      final okNotif = await NotificationService().showBasic('Alerta disparado', time);

      notifyListeners();
      return okNotif; // true se notificação ok, false se notificação falhou (mas DB ok)
    } catch (e) {
      // se quiser, logue o erro: print(e);
      return false;
    }
  }

  Future<List<AlertModel>> getHistory() => _db.getAll();

  Future<void> fetchApiStatus() async {
    try {
      final req = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
      apiStatus = req.statusCode == 200 ? 'Online' : 'Offline';
    } catch (_) {
      apiStatus = 'Offline';
    }
    notifyListeners();
  }
}