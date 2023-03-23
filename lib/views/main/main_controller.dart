import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/api/application.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/models/base/ad.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/models/responses/main.dart';
import 'package:flutter_application/repositories/dowloaded_repository.dart';
import 'package:flutter_application/repositories/liked_repository.dart';
import 'package:flutter_application/services/ad_service.dart';
import 'package:flutter_application/utils/getx_base_view_model.dart';
import 'package:flutter_application/views/main/views/categories_view/categories_view.dart';
import 'package:flutter_application/views/main/views/preview/preview_view.dart';
import 'package:flutter_application/views/main/views/selected_category/selected_category_view.dart';
import 'package:flutter_application/views/main/views/selected_game/selected_game_view.dart';
import 'package:get/get.dart';

enum MODE { preview, categories, selectedCategory, selectedGame }

class MainController extends GetxBaseViewModel {
  List<Enum> navigationStack = [MODE.preview];

  MainResponse? response;
  Ad? ad;

  @override
  void onInit() async {
    super.onInit();
    runFuture(() async {
      response = await ApplicationAPI.getMain();
      ad = response?.application.ad;

      await Get.putAsync(() async {
        return AdService(ad: ad!);
      }, permanent: true);
    });
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == AppLinks.preview) {
      return GetPageRoute(page: () => const PreviewView(), settings: settings);
    } else if (settings.name == AppLinks.categories) {
      return GetPageRoute(
          page: () => const CategoriesView(), settings: settings);
    } else if (settings.name == AppLinks.selectedCategory) {
      return GetPageRoute(
          page: () =>
              SelectedCategoryView(category: settings.arguments as Category),
          settings: settings);
    } else if (settings.name == AppLinks.selectedGame) {
      return GetPageRoute(
          page: () => SelectedGameView(game: settings.arguments as Game),
          settings: settings);
    }
    return null;
  }
}
