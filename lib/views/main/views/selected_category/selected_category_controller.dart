import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/constants/keys.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/services/ad_service.dart';
import 'package:flutter_application/utils/getx_base_view_model.dart';
import 'package:flutter_application/views/main/common.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SelectedCategoryController extends GetxBaseViewModel {
  Category category;
  List<Widget> children = [];

  SelectedCategoryController({required this.category});

  void onInit() async {
    super.onInit();
    debugger();
    Widget ad = Get.find<AdService>().syncYandexNativeAd();

    for (int i = 0; i < category.gamesTop.length; i++) {
      children.add(Common.gameCard(category.gamesTop[i], (game) {
        Get.toNamed(AppLinks.selectedGame, id: 1, arguments: game);
      }));

      if (Get.find<AdService>().needToShowNative(gameIndex: i)) {
        children.add(Get.find<AdService>().syncYandexNativeAd());
      }
    }
    update();
  }
}
