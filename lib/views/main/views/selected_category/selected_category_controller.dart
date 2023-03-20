import 'package:flutter_application/models/base/category.dart';
import 'package:get/get.dart';

class SelectedCategoryController extends GetxController {
  Category? category;
  @override
  void onInit() {
    category = Get.arguments;
    super.onInit();
  }
}
