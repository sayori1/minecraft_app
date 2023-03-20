import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/views/main/main_controller.dart';
import 'package:flutter_application/views/main/views/categories_view/categories_controller.dart';
import 'package:flutter_application/views/main/widgets/card.dart';
import 'package:flutter_application/views/main/widgets/colored_category.dart';
import 'package:flutter_application/views/main/common.dart';
import 'package:flutter_application/views/main/widgets/small_card.dart';
import 'package:flutter_application/utils/utils.dart';
import 'package:get/get.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesController>(builder: (model) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Категории'),
            shadowColor: Colors.transparent,
            backgroundColor: Pallete.blue,
            leading: BackButton(
              onPressed: () {
                model.back();
              },
            ),
          ),
          body: SingleChildScrollView(
              child: Column(
            children: [
              Common.categories(model, 0),
            ],
          )));
    });
  }
}
