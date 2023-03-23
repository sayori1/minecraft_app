import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppKeys {
  static int keyAcc = 0;

  static int rootNav = getKey();
  static GlobalKey<NavigatorState> rootNavigationKey = Get.nestedKey(rootNav)!;

  static int mainNav = getKey();
  static GlobalKey<NavigatorState> mainNavigationKey = Get.nestedKey(mainNav)!;

  static int getKey() {
    return keyAcc++;
  }
}
