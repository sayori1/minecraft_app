import 'package:flutter_application/main.dart';
import 'package:flutter_application/views/likes/likes_controller.dart';
import 'package:get/get.dart';

enum Tabs { main, likes, feedback }

class RootController extends GetxController {
  RxInt selectedTab = 0.obs;

  goToTab(int index) async {
    if (index == Tabs.main.index) {
      Get.toNamed(AppLinks.main, id: 0, preventDuplicates: true);
    }
    if (index == Tabs.likes.index) {
      if (Get.isRegistered<LikesController>()) {
        Get.find<LikesController>().load();
      }
      Get.toNamed(AppLinks.likes, id: 0, preventDuplicates: true);
    }
    if (index == 2) {
      Get.toNamed(AppLinks.feedback, id: 0, preventDuplicates: true);
    }

    selectedTab.value = index;
  }
}
