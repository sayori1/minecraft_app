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
  static Builder categories(MainController model, start, [int? end]) {
    return Builder(builder: ((context) {
      List<Category> categories =
          model.response!.categories.sublist(start, end);

      return Column(children: [
        ...categories.map((e) {
          return ColoredCategory(
              horizontalCount: 2,
              categoryName: e.title,
              children: e.gamesTop
                  .sublist(0, 2)
                  .map((e) => SmallCard(
                      onTap: () => model.goToGame(e),
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
                model.selectedCategory = e;
                model.goTo(mode.selectedCategory);
              });
        }).toList()
      ]);
    }));
  }

  static Builder firstCategory(MainController model) {
    return Builder(builder: ((context) {
      Category category = model.response!.categories.first;
      List<Widget> children = model.response!.categories.first.gamesTop
          .map((e) => AppCard(
              onTap: () {
                model.goToGame(e);
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
            model.goTo(mode.categories);
          });
    }));
  }
}
