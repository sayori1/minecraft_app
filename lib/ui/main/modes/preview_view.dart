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

class PreviewView extends StatelessWidget {
  const PreviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (model) {
      return SingleChildScrollView(
        child: model.response != null
            ? Column(
                children: [
                  Common.firstCategory(model),
                  Common.categories(model, 1),
                ],
              )
            : const Center(
                child: Padding(
                padding: EdgeInsets.only(top: 200),
                child: CircularProgressIndicator(),
              )),
      );
    });
  }
}
