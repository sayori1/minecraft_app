import 'package:flutter/material.dart';
import 'package:flutter_application/constants/keys.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/models/base/game.dart';
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
      autoRemove: false,
      builder: (model) {
        return SafeArea(
          child: model.response == null
              ? const Center(
                  child: Padding(
                  padding: EdgeInsets.only(top: 200),
                  child: CircularProgressIndicator(),
                ))
              : Navigator(
                  key: AppKeys.mainNavigationKey,
                  initialRoute: AppLinks.preview,
                  onGenerateRoute: ((settings) {
                    if (settings.name == AppLinks.preview) {
                      return GetPageRoute(
                          page: () => const PreviewView(), settings: settings);
                    } else if (settings.name == AppLinks.categories) {
                      return GetPageRoute(
                          page: () => const CategoriesView(),
                          settings: settings);
                    } else if (settings.name == AppLinks.selectedCategory) {
                      return GetPageRoute(
                          page: () => SelectedCategoryView(
                              category: settings.arguments as Category),
                          settings: settings);
                    } else if (settings.name == AppLinks.selectedGame) {
                      return GetPageRoute(
                          page: () => SelectedGameView(
                              game: settings.arguments as Game),
                          settings: settings);
                    }
                    return null;
                  }),
                ),
        );
      },
    );
  }
}
