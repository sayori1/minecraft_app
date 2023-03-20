import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/constants/keys.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/views/feedback/feedback_view.dart';
import 'package:flutter_application/views/likes/likes_controller.dart';
import 'package:flutter_application/views/likes/likes_view.dart';
import 'package:flutter_application/views/main/main_view.dart';
import 'package:flutter_application/views/root/root_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RootView extends StatelessWidget {
  const RootView();

  @override
  Widget build(BuildContext context) {
    return GetX<RootController>(
        init: Get.put(RootController()),
        builder: (model) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            resizeToAvoidBottomInset: false,
            extendBody: true,
            body: Navigator(
              key: AppKeys.rootNavigationKey,
              initialRoute: AppLinks.main,
              onGenerateRoute: ((settings) {
                if (settings.name == AppLinks.main) {
                  return GetPageRoute(page: () => MainView());
                } else if (settings.name == AppLinks.likes) {
                  return GetPageRoute(page: () => LikesView());
                } else if (settings.name == AppLinks.feedback) {
                  return GetPageRoute(page: () => FeedbackView());
                }
              }),
            ),
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.blue.withOpacity(0.5),
              currentIndex: model.selectedTab.value,
              onTap: (index) => model.goToTab(index),
              items: [
                bottonNavBarItem(model, 'assets/icons/home.svg', 0),
                bottonNavBarItem(model, 'assets/icons/heart_grey.svg', 1),
                bottonNavBarItem(model, 'assets/icons/feedback.svg', 2),
              ],
            ),
          );
        });
  }

  BottomNavigationBarItem bottonNavBarItem(
      RootController model, String asset, int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(asset,
          color:
              model.selectedTab.value == index ? Pallete.blue : Pallete.gray),
      label: '',
    );
  }
}
