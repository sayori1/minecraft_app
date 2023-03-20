import 'package:flutter_application/api/api.dart';
import 'package:flutter_application/models/base/category.dart';

class GameCategoryAPI {
  static Future<Category> get(String id) async {
    dynamic json = await API.httpGet('game-category/index', {'id': id});
    return Category.fromJson(json);
  }
}
