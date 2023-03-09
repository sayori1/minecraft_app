import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/ui/main/main_controller.dart';
import 'package:flutter_application/ui/main/widgets/card.dart';
import 'package:flutter_application/ui/main/widgets/colored_category.dart';
import 'package:flutter_application/ui/main/common.dart';
import 'package:flutter_application/ui/main/widgets/small_card.dart';
import 'package:flutter_application/utils/utils.dart';
import 'package:get/get.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (model) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Категории'),
            shadowColor: Colors.transparent,
            backgroundColor: Pallete.blue,
            leading: BackButton(
              onPressed: () {
                model.changeMode(mode.preview);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: model.response != null
                ? Column(
                    children: [
                      Common.categories(model, 0),
                    ],
                  )
                : Center(
                    child: Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: CircularProgressIndicator(),
                  )),
          ));
    });
  }
}
