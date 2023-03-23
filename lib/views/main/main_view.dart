import 'package:flutter/material.dart';
import 'package:flutter_application/constants/keys.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/services/ad_service.dart';
import 'package:flutter_application/views/main/main_controller.dart';
import 'package:flutter_application/views/main/views/categories_view/categories_view.dart';
import 'package:flutter_application/views/main/views/preview/preview_controller.dart';
import 'package:flutter_application/views/main/views/preview/preview_view.dart';
import 'package:flutter_application/views/main/views/selected_category/selected_category_view.dart';
import 'package:flutter_application/views/main/views/selected_game/selected_game_view.dart';
import 'package:get/get.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      autoRemove: false,
      builder: (model) {
        return SafeArea(
          child: model.isBusy
              ? const Center(
                  child: Padding(
                  padding: EdgeInsets.only(top: 200),
                  child: CircularProgressIndicator(),
                ))
              : Navigator(
                  key: AppKeys.mainNavigationKey,
                  initialRoute: AppLinks.preview,
                  onGenerateRoute: model.onGenerateRoute),
        );
      },
    );
  }
}
