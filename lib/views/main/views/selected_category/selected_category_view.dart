import 'package:flutter/material.dart';
import 'package:flutter_application/constants/keys.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/services/ad_service.dart';
import 'package:flutter_application/views/main/common.dart';
import 'package:flutter_application/views/main/views/selected_category/selected_category_controller.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SelectedCategoryView extends StatelessWidget {
  final Category category;

  const SelectedCategoryView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    Get.find<AdService>().visitNewPage();

    return GetBuilder<SelectedCategoryController>(
        init: SelectedCategoryController(category: category),
        builder: (model) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(model.category!.title),
              leading: BackButton(
                onPressed: () {
                  Get.back(id: 1);
                },
              ),
            ),
            body: model.isBusy
                ? const Center(
                    child: Padding(
                    padding: EdgeInsets.only(top: 200),
                    child: CircularProgressIndicator(),
                  ))
                : Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                    child: SingleChildScrollView(
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: model.children,
                      ),
                    ),
                  ),
          );
        });
  }
}
