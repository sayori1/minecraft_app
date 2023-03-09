import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/constants/text_styles.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/ui/main/main_controller.dart';
import 'package:flutter_application/ui/main/modes/categories_view.dart';
import 'package:flutter_application/ui/main/modes/preview_view.dart';
import 'package:flutter_application/ui/main/modes/selected_category_view.dart';
import 'package:flutter_application/ui/main/modes/selected_game_view.dart';
import 'package:flutter_application/ui/main/widgets/card.dart';
import 'package:flutter_application/ui/main/widgets/category.dart';
import 'package:flutter_application/ui/main/widgets/colored_category.dart';
import 'package:flutter_application/ui/main/common.dart';
import 'package:flutter_application/ui/main/widgets/small_card.dart';
import 'package:flutter_application/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (model) {
        return WillPopScope(
          onWillPop: () async {
            model.changeMode(mode.preview);
            return false;
          },
          child: SafeArea(
            child: Scaffold(
                backgroundColor: AppColors.backgroundColor,
                body: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    child: Builder(builder: ((context) {
                      if (model.selectedMode == mode.preview)
                        return PreviewView();
                      else if (model.selectedMode == mode.categories)
                        return CategoriesView();
                      else if (model.selectedMode == mode.selectedCategory)
                        return SelectedCategoryView();
                      else if (model.selectedMode == mode.selectedGame)
                        return SelectedGameView();
                      else
                        return Container();
                    })))),
          ),
        );
      },
    );
  }
}
