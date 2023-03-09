import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application/constants/env.dart';
import 'package:flutter_application/models/base/application.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/models/responses/main.dart';
import 'package:http/http.dart';

class ApplicationApi {
  static Future<MainResponse> getMain(
      [String packageName = 'com.test.test']) async {
    Uri url =
        Uri.parse(Env.apiUrl + 'application/main?package_name=' + packageName);

    print(url.toString());
    var json = jsonDecode((await get(url)).body);
    return MainResponse.fromJson(json);
  }
}
