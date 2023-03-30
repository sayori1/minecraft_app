import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/services/ad_service.dart';
import 'package:flutter_application/utils/getx_base_view_model.dart';
import 'package:flutter_application/views/main/common.dart';
import 'package:flutter_application/views/main/main_controller.dart';
import 'package:get/get.dart';

class PreviewController extends GetxBaseViewModel {
  List<Category> categories = [];
  Widget? fullCategory;

  @override
  void onInit() async {
    super.onInit();
    runFuture(() async {
      categories = Get.find<MainController>().response!.categories;
      fullCategory =
          await Common.fullCategory(categories.first, onGameTap: (Game game) {
        Get.toNamed(AppLinks.selectedGame, id: 1, arguments: game);
      }, onButtonTap: () {
        Get.toNamed(AppLinks.categories, id: 1);
      }, withAds: true);
    });
  }

  void refreshAd() async {
    runFuture(() async {
      fullCategory =
          await Common.fullCategory(categories.first, onGameTap: (Game game) {
        Get.toNamed(AppLinks.selectedGame, id: 1, arguments: game);
      }, onButtonTap: () {
        Get.toNamed(AppLinks.categories, id: 1);
      }, withAds: true);
    });
  }
}
