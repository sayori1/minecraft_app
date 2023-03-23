import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/services/ad_service.dart';
import 'package:flutter_application/utils/getx_base_view_model.dart';
import 'package:flutter_application/views/main/main_controller.dart';
import 'package:get/get.dart';

class PreviewController extends GetxBaseViewModel {
  List<Category> categories = [];
  Widget? ad;

  @override
  void onInit() async {
    super.onInit();
    runFuture(() async {
      categories = Get.find<MainController>().response!.categories;
      ad = await Get.find<AdService>().asyncNativeAd();
    });
  }

  void refreshAd() async {
    runFuture(() async {
      ad = await Get.find<AdService>().asyncNativeAd();
    });
  }
}
