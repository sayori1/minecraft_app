import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppKeys {
  static GlobalKey<NavigatorState> rootNavigationKey = Get.nestedKey(0)!;
  static GlobalKey<NavigatorState> mainNavigationKey = Get.nestedKey(1)!;
}
