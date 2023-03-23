import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/services/ad_service.dart';
import 'package:flutter_application/views/main/common.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SelectedCategoryController extends GetxController {
  Category category;
  List<Widget> children = [];
  bool isBusy = false;

  SelectedCategoryController({required this.category});

  void onInit() async {
    isBusy = true;
    AdService adService = Get.find();

    for (int i = 0; i < category.gamesTop.length; i++) {
      children.add(Common.gameCard(category.gamesTop[i], (game) {
        Get.toNamed(AppLinks.selectedGame, id: 1, arguments: game);
      }));
      if (adService.showNative(gameIndex: i)) {
        Widget ad = await adService.asyncNativeAd();
        children.add(ad);
      }
    }
    isBusy = false;
    update();
  }
}
