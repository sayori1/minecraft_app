import 'dart:convert';

import 'package:flutter_application/constants/env.dart';
import 'package:http/http.dart';

class API {
  static dynamic httpGet(String path,
      [Map<String, dynamic> queryParameters = const {}]) async {
    Uri url = Uri.https(Env.apiUrl, '${Env.version}/$path', queryParameters);
    Response response = await get(url);
    dynamic json = jsonDecode(response.body);
    return json;
  }

  static dynamic httpPost(String path,
      [Map<String, dynamic> queryParameters = const {},
      Map<String, dynamic> body = const {}]) async {
    Uri url = Uri.https(Env.apiUrl, '${Env.version}/$path', queryParameters);
    Response response = await post(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    dynamic json = jsonDecode(response.body);
    return json;
  }
}
