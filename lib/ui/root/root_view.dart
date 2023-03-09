import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/ui/feedback/feedback_view.dart';
import 'package:flutter_application/ui/likes/likes_view.dart';
import 'package:flutter_application/ui/main/main_view.dart';
import 'package:flutter_application/ui/root/root_controller.dart';
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
            body: Stack(
              children: [
                IndexedStack(
                  index: model.selectedTab.value,
                  children: <Widget>[
                    Navigator(
                      key: Get.nestedKey(Tabs.main.index),
                      observers: [HeroController()],
                      onGenerateRoute: (settings) => GetPageRoute<dynamic>(
                        settings: settings,
                        page: () => const MainView(),
                      ),
                    ),
                    Navigator(
                      key: Get.nestedKey(Tabs.likes.index),
                      observers: [HeroController()],
                      onGenerateRoute: (settings) => GetPageRoute<dynamic>(
                        settings: settings,
                        page: () => const LikesView(),
                      ),
                    ),
                    Navigator(
                      key: Get.nestedKey(Tabs.feedback.index),
                      observers: [HeroController()],
                      onGenerateRoute: (settings) => GetPageRoute<dynamic>(
                        settings: settings,
                        page: () => const FeedbackView(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.blue.withOpacity(0.5),
              currentIndex: model.selectedTab.value,
              onTap: (index) {
                model.selectedTab.value = index;
              },
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
