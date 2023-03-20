import 'dart:developer';

import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/views/main/main_controller.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  List<Category> categories = [];

  @override
  void onInit() {
    categories = Get.find<MainController>().response!.categories;
    super.onInit();
  }
}
