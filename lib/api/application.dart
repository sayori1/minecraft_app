import 'dart:developer';

import 'package:flutter_application/api/api.dart';
import 'package:flutter_application/models/responses/main.dart';

class ApplicationAPI {
  static MainResponse? mainCache;

  static Future<MainResponse> getMain(
      [String packageName = 'com.test.test']) async {
    if (mainCache != null) return mainCache!;
    dynamic json =
        await API.httpGet('application/main', {'package_name': packageName});
    mainCache = MainResponse.fromJson(json);
    return mainCache!;
  }
}
