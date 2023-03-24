import 'package:flutter/material.dart';
import 'package:flutter_application/constants/keys.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/services/ad_service.dart';
import 'package:flutter_application/views/main/main_controller.dart';
import 'package:flutter_application/views/main/common.dart';
import 'package:flutter_application/views/main/views/preview/preview_controller.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class PreviewView extends StatefulWidget {
  const PreviewView({super.key});

  @override
  State<PreviewView> createState() => _PreviewViewState();
}

class _PreviewViewState extends State<PreviewView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviewController>(
        init: PreviewController(),
        builder: (model) {
          return SingleChildScrollView(
            child: model.isBusy
                ? const Center(
                    child: Padding(
                    padding: EdgeInsets.only(top: 200),
                    child: CircularProgressIndicator(),
                  ))
                : Column(
                    children: [
                      model.ad!,
                      Common.fullCategory(model.categories.first,
                          onGameTap: (Game game) {
                        Get.toNamed(AppLinks.selectedGame,
                            id: 1, arguments: game);
                      }, onButtonTap: () {
                        Get.toNamed(AppLinks.categories, id: 1);
                      }, withAds: false),
                      Common.categories(model.categories, start: 1,
                          onGameTap: (Game game) {
                        Get.toNamed(AppLinks.selectedGame,
                            id: 1, arguments: game);
                      }, onCategoryTap: (Category category) {
                        Get.toNamed(AppLinks.selectedCategory,
                            id: 1, arguments: category);
                      }),
                    ],
                  ),
          );
        });
  }
}
