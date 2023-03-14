import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application/constants/env.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:http/http.dart';

class GameApi {
  static Future<Game> getGame(String id) async {
    Uri url = Uri.parse(Env.apiUrl + 'game/view?id=' + id);

    print(url.toString());
    var json = jsonDecode((await get(url)).body);
    return Game.fromJson(json);
  }
}
