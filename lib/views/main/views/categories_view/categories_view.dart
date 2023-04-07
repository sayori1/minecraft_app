import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/constants/keys.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/services/ad_service.dart';
import 'package:flutter_application/views/main/main_controller.dart';
import 'package:flutter_application/views/main/views/categories_view/categories_controller.dart';
import 'package:flutter_application/views/main/common.dart';
import 'package:flutter_application/views/main/views/preview/preview_controller.dart';
import 'package:flutter_application/views/root/root_controller.dart';
import 'package:get/get.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesController>(
        init: CategoriesController(),
        builder: (model) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Категории'),
                shadowColor: Colors.transparent,
                backgroundColor: Pallete.blue,
                leading: BackButton(
                  onPressed: () {
                    Get.find<MainController>().goToPreview();
                  },
                ),
              ),
              body: SingleChildScrollView(
                  child: Column(
                children: [
                  Common.categories(model.categories, onGameTap: (Game game) {
                    Get.toNamed(AppLinks.selectedGame, id: 1, arguments: game);
                  }, onCategoryTap: (Category category) {
                    Get.toNamed(AppLinks.selectedCategory,
                        id: 1, arguments: category);
                  }),
                ],
              )));
        });
  }
}
