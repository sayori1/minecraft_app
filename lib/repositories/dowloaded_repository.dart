import 'package:shared_preferences/shared_preferences.dart';

class RatedRepository {
  static const String _key = 'rated_files';
  static SharedPreferences? _prefs;

  static Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<bool> isRated(String id) async {
    await _initPrefs();
    final ratedFiles = _prefs!.getStringList(_key) ?? [];
    return ratedFiles.contains(id);
  }

  static Future<void> addRated(String id) async {
    await _initPrefs();
    final downloadedFiles = _prefs!.getStringList(_key) ?? [];
    downloadedFiles.add(id);
    _prefs!.setStringList(_key, downloadedFiles);
  }
}
