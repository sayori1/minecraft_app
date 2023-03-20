import 'package:flutter_application/api/api.dart';
import 'package:flutter_application/models/responses/main.dart';

class ApplicationAPI {
  static Future<MainResponse> getMain(
      [String packageName = 'com.test.test']) async {
    dynamic json =
        await API.httpGet('application/main', {'package_name': packageName});
    return MainResponse.fromJson(json);
  }
}
