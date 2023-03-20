import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application/api/api.dart';
import 'package:flutter_application/constants/env.dart';
import 'package:flutter_application/models/base/application.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/models/responses/main.dart';
import 'package:http/http.dart';

class ApplicationAPI {
  static Future<MainResponse> getMain(
      [String packageName = 'com.test.test']) async {
    dynamic json =
        await API.httpGet('application/main', {'package_name': packageName});
    return MainResponse.fromJson(json);
  }
}
