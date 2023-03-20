import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/views/main/main_controller.dart';
import 'package:flutter_application/views/main/common.dart';
import 'package:get/get.dart';

class PreviewView extends StatelessWidget {
  const PreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (model) {
      return SingleChildScrollView(
        child: model.response != null
            ? Column(
                children: [
                  Common.fullCategory(model.response!.categories.first,
                      onGameTap: (Game game) {
                    Get.toNamed(AppLinks.selectedGame, id: 1, arguments: game);
                  }, onButtonTap: () {
                    Get.toNamed(AppLinks.categories, id: 1);
                  }),
                  Common.categories(model.response!.categories, start: 1,
                      onGameTap: (Game game) {
                    Get.toNamed(AppLinks.selectedGame, id: 1, arguments: game);
                  }, onCategoryTap: (Category category) {
                    Get.toNamed(AppLinks.selectedCategory,
                        id: 1, arguments: category);
                  }),
                ],
              )
            : const Center(
                child: Padding(
                padding: EdgeInsets.only(top: 200),
                child: CircularProgressIndicator(),
              )),
      );
    });
  }
}
