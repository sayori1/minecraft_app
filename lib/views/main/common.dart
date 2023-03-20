import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/views/main/main_controller.dart';
import 'package:flutter_application/views/main/widgets/card.dart';
import 'package:flutter_application/views/main/widgets/category.dart';
import 'package:flutter_application/views/main/widgets/colored_category.dart';
import 'package:flutter_application/views/main/widgets/small_card.dart';
import 'package:flutter_application/utils/utils.dart';
import 'package:get/get.dart';

class Common {
  static Builder categories(List<Category> allCategories,
      {int start = 0,
      int? end,
      required Function(Game) onGameTap,
      required Function(Category) onCategoryTap}) {
    return Builder(builder: ((context) {
      List<Category> categories = allCategories.sublist(start, end);

      return Column(children: [
        ...categories.map((e) {
          return ColoredCategory(
              horizontalCount: 2,
              categoryName: e.title,
              children: e.gamesTop
                  .sublist(0, 2)
                  .map((e) => SmallCard(
                      onTap: () => onGameTap(e),
                      downloads: e.installAmount,
                      image: e.logo,
                      title: e.title,
                      category: e.type,
                      grade: e.rating.toDouble(),
                      size: Utils.bytesToMegabytes(e.file.size).toString() +
                          ' MB',
                      version: 'VER: 1,5'))
                  .toList(),
              buttonText: "Показать все",
              onTap: () {
                onCategoryTap(e);
              });
        }).toList()
      ]);
    }));
  }

  static Builder fullCategory(Category category,
      {required Function(Game) onGameTap, required Function onButtonTap}) {
    return Builder(builder: ((context) {
      List<Widget> children = category.gamesTop
          .map((e) => AppCard(
              onTap: () {
                onGameTap(e);
              },
              image: e.logo,
              title: e.title,
              category: e.type,
              downloads: e.priority,
              grade: e.rating.toDouble(),
              size: Utils.bytesToMegabytes(e.file.size).toString() + ' MB',
              version: 'VER: 1,5'))
          .toList();

      return AppCategory(
          categoryName: category.title,
          horizontalCount: 1,
          children: children,
          buttonText: 'Еще категории',
          onTap: () {
            onButtonTap();
          });
    }));
  }
}
