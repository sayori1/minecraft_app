import 'package:flutter_application/main.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/views/likes/likes_controller.dart';
import 'package:flutter_application/views/main/views/preview/preview_controller.dart';
import 'package:get/get.dart';

enum Tabs { main, likes, feedback }

class RootController extends GetxController {
  RxInt selectedTab = 0.obs;
  List<Enum> stack = [Tabs.main];

  void goToTab(int index, {addToStack = true}) async {
    if (index == selectedTab.value) return;
    if (addToStack) stack.add(Tabs.values[index]);

    if (index == Tabs.main.index) {
      Get.offAndToNamed(AppLinks.main, id: 0);
    }
    if (index == Tabs.likes.index) {
      if (Get.isRegistered<LikesController>()) {
        Get.find<LikesController>().load();
      }
      Get.offAndToNamed(AppLinks.likes, id: 0);
    }
    if (index == 2) {
      Get.offAndToNamed(AppLinks.feedback, id: 0);
    }

    selectedTab.value = index;
  }

  void goToGame(Game game) async {
    goToTab(0);
    await Future.delayed(100.milliseconds);
    await Get.find<PreviewController>().isLoaded.future;
    await Get.toNamed(AppLinks.selectedGame, id: 1, arguments: game);
  }

  void back() {
    stack.removeLast();
    goToTab(stack.last.index, addToStack: false);
  }
}
