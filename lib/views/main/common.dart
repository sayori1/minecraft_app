import 'package:flutter/material.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/views/main/widgets/card.dart';
import 'package:flutter_application/views/main/widgets/category.dart';
import 'package:flutter_application/views/main/widgets/colored_category.dart';
import 'package:flutter_application/views/main/widgets/small_card.dart';
import 'package:flutter_application/utils/utils.dart';

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

  static Builder fullCategory(Category category,
      {required Function(Game) onGameTap, required Function onButtonTap}) {
    return Builder(builder: ((context) {
      List<Widget> children =
          category.gamesTop.map((e) => gameCard(e, onGameTap)).toList();

      return AppCategory(
          categoryName: category.title,
          horizontalCount: 1,
          buttonText: 'Еще категории',
          onTap: () {
            onButtonTap();
          },
          children: children);
    }));
  }
}
