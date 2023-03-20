import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/views/main/common.dart';
import 'package:flutter_application/views/main/views/selected_category/selected_category_controller.dart';
import 'package:get/get.dart';

class SelectedCategoryView extends StatelessWidget {
  const SelectedCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectedCategoryController>(
        init: SelectedCategoryController(),
        builder: (model) {
          List<Widget> children = model.category!.gamesTop
              .map((e) => Common.gameCard(
                  e,
                  (game) => Get.toNamed(AppLinks.selectedGame,
                      id: 1, arguments: game)))
              .toList();

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(model.category!.title),
              leading: BackButton(
                onPressed: () {
                  Get.back(id: 1);
                },
              ),
            ),
            body: SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: children.map((child) {
                  return child;
                }).toList(),
              ),
            ),
          );
        });
  }
}
