import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DownloadRepository {
  static const String _key = 'downloaded_files';
  static SharedPreferences? _prefs;

  static Future<void> _initPrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  static Future<bool> isDownloaded(String id) async {
    await _initPrefs();
    final downloadedFiles = _prefs!.getStringList(_key) ?? [];
    return downloadedFiles.contains(id);
  }

  static Future<void> addDownloaded(String id) async {
    await _initPrefs();
    final downloadedFiles = _prefs!.getStringList(_key) ?? [];
    downloadedFiles.add(id);
    _prefs!.setStringList(_key, downloadedFiles);
  }
}
