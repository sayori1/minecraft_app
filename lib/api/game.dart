import 'package:flutter_application/api/api.dart';
import 'package:flutter_application/models/base/game.dart';

class GameAPI {
  static Future<Game> get(String id) async {
    dynamic json = await API.httpGet('game/view', {'id': id});
    return Game.fromJson(json);
  }

  static Future<Game> like(String id) async {
    dynamic json = await API.httpPost('game/like', {'id': id});
    return Game.fromJson(json);
  }

  static Future<Game> install(String id) async {
    dynamic json = await API.httpPost('game/install', {'id': id});
    return Game.fromJson(json);
  }

  static Future<Game> report(
      String id, String? reportText, String? version) async {
    dynamic json = await API.httpPost('game/report', {'id': id},
        {"report_text": reportText, "minecraft_version": version});
    return Game.fromJson(json);
  }
}
