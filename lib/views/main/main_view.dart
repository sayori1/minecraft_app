import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/constants/keys.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/views/main/main_controller.dart';
import 'package:flutter_application/views/main/views/categories_view/categories_view.dart';
import 'package:flutter_application/views/main/views/preview/preview_view.dart';
import 'package:flutter_application/views/main/views/selected_category/selected_category_view.dart';
import 'package:flutter_application/views/main/views/selected_game/selected_game_view.dart';
import 'package:get/get.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (model) {
        return SafeArea(
          child: model.response == null
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: CircularProgressIndicator(),
                ))
              : Navigator(
                  key: AppKeys.mainNavigationKey,
                  initialRoute: AppLinks.preview,
                  onGenerateRoute: ((settings) {
                    if (settings.name == AppLinks.preview) {
                      return GetPageRoute(page: () => PreviewView());
                    } else if (settings.name == AppLinks.categories) {
                      return GetPageRoute(page: () => CategoriesView());
                    } else if (settings.name == AppLinks.selected_category) {
                      return GetPageRoute(page: () => SelectedCategoryView());
                    } else if (settings.name == AppLinks.selected_game) {
                      return GetPageRoute(page: () => SelectedGameView());
                    }
                  }),
                ),
        );
      },
    );
  }
}
