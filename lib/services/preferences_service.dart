import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future<void> save({
    required bool vibration,
    required bool sound,
    required bool banner,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('vibration', vibration);
    prefs.setBool('sound', sound);
    prefs.setBool('banner', banner);
  }

  Future<Map<String, bool>> load() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'vibration': prefs.getBool('vibration') ?? true,
      'sound': prefs.getBool('sound') ?? true,
      'banner': prefs.getBool('banner') ?? true,
    };
  }
}
