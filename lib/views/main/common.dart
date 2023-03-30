import 'package:flutter/material.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/services/ad_service.dart';
import 'package:flutter_application/views/main/widgets/card.dart';
import 'package:flutter_application/views/main/widgets/category.dart';
import 'package:flutter_application/views/main/widgets/colored_category.dart';
import 'package:flutter_application/views/main/widgets/small_card.dart';
import 'package:flutter_application/utils/utils.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Common {
  static Widget smallGameCard(Game game, Function(Game) onTap) {
    return SmallCard(
        onTap: () => onTap(game),
        downloads: game.installAmount,
        image: game.logo,
        title: game.title,
        category: game.type,
        grade: game.rating.toDouble(),
        size: '${Utils.bytesToMegabytes(game.file.size)} MB',
        version: 'VER: 1,5');
  }

  static Widget gameCard(Game game, Function(Game) onTap) {
    return AppCard(
        onTap: () => onTap(game),
        downloads: game.installAmount,
        image: game.logo,
        title: game.title,
        category: game.type,
        grade: game.rating.toDouble(),
        size: '${Utils.bytesToMegabytes(game.file.size)} MB',
        version: 'VER: 1,5');
  }

  static Builder categories(
    List<Category> allCategories, {
    int start = 0,
    int? end,
    required Function(Game) onGameTap,
    required Function(Category) onCategoryTap,
  }) {
    return Builder(builder: ((context) {
      List<Category> categories = allCategories.sublist(start, end);

      return Column(children: [
        ...categories.map((e) {
          return ColoredCategory(
              horizontalCount: 2,
              categoryName: e.title,
              buttonText: "Показать все",
              onTap: () {
                onCategoryTap(e);
              },
              children: e.gamesTop
                  .sublist(0, 2)
                  .map((e) => smallGameCard(e, onGameTap))
                  .toList());
        }).toList()
      ]);
    }));
  }

  static Future<Widget> fullCategory(Category category,
      {required Function(Game) onGameTap,
      required Function onButtonTap,
      withAds = false}) async {
    AdService adService = Get.find();
    List<Widget> children = [];

    for (int i = 2; i < category.gamesTop.length; i++) {
      children.add(gameCard(category.gamesTop[i], onGameTap));
      if (withAds &&
          Get.find<AdService>()
              .needToShowNative(gameIndex: i - 2, isInMainPage: true)) {
        children.add(await Get.find<AdService>().asyncNativeAd());
      }
    }
    return AppCategory(
        categoryName: category.title,
        horizontalCount: 1,
        buttonText: 'Еще категории',
        onTap: () {
          onButtonTap();
        },
        children: children);
  }
}
