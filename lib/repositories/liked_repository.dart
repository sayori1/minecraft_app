import 'package:shared_preferences/shared_preferences.dart';

class LikedRepository {
  static const String _key = 'liked_files';
  static SharedPreferences? _prefs;

  static Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<bool> isLiked(String id) async {
    await _initPrefs();
    final likedGames = _prefs!.getStringList(_key) ?? [];
    return likedGames.contains(id);
  }

  static Future<void> addLiked(String id) async {
    await _initPrefs();
    final likedGames = _prefs!.getStringList(_key) ?? [];
    if (!likedGames.contains(id)) likedGames.add(id);
    _prefs!.setStringList(_key, likedGames);
  }

  static Future<void> deleteLiked(String id) async {
    await _initPrefs();
    final likedGames = _prefs!.getStringList(_key) ?? [];
    likedGames.remove(id);
    _prefs!.setStringList(_key, likedGames);
  }

  static Future<List<String>> getList() async {
    await _initPrefs();
    final likedGames = _prefs!.getStringList(_key) ?? [];
    return likedGames;
  }
}
