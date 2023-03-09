import 'package:get/get.dart';

enum Tabs { main, likes, feedback }

class RootController extends GetxController {
  RxInt selectedTab = 0.obs;
}
