import 'dart:convert';

import 'package:flutter_application/constants/env.dart';
import 'package:http/http.dart';

class API {
  static dynamic httpGet(String path,
      [Map<String, dynamic> queryParameters = const {}]) async {
    Uri url = Uri.https(Env.apiUrl, '${Env.version}/$path', queryParameters);
    print('[network]: REQUEST ' + url.toString());
    Response response = await get(url);
    print('[network]: RESPONSE ' + response.toString());
    dynamic json = jsonDecode(response.body);
    return json;
  }

  static dynamic httpPost(String path,
      [Map<String, dynamic> queryParameters = const {},
      Map<String, dynamic> body = const {}]) async {
    Uri url = Uri.https(Env.apiUrl, '${Env.version}/$path', queryParameters);
    print('[network]: REQUEST ' + url.toString());
    Response response = await post(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    print('[network]: RESPONSE ' + response.toString());
    dynamic json = jsonDecode(response.body);
    return json;
  }
}
