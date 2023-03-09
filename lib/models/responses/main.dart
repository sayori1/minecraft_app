import 'package:flutter_application/models/base/application.dart';
import 'package:flutter_application/models/base/category.dart';

class MainResponse {
  Application application;
  List<Category> categories;

  MainResponse({required this.application, this.categories = const []});

  factory MainResponse.fromJson(Map<String, dynamic> json) {
    return MainResponse(
        application: Application.fromJson(json['application']),
        categories: json['categories']
            .map<Category>((x) => Category.fromJson(x))
            .toList());
  }
}
