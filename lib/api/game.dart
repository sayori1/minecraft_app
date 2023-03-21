import 'package:flutter_application/api/api.dart';
import 'package:flutter_application/models/base/game.dart';

class GameAPI {
  static Future<Game> get(String id) async {
    dynamic json = await API.httpGet('game/view', {'id': id});
    return Game.fromJson(json);
  }

  static Future<void> like(String id) async {
    dynamic json = await API.httpPost('game/like', {'id': id});
  }

  static Future<void> install(String id) async {
    dynamic json = await API.httpPost('game/install', {'id': id});
  }

  static Future<void> report(
      String id, String? reportText, String? version) async {
    dynamic json = await API.httpPost('game/report', {'id': id},
        {"report_text": reportText, "minecraft_version": version});
  }

  static Future<void> request(String? reportText, {int ad = 1}) async {
    dynamic json = await API.httpPost(
        'game/request', {}, {"request_text": reportText, "disable_ad": ad});
  }
}
