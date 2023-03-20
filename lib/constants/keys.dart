import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppKeys {
  static int keyAcc = 0;
  static final GlobalKey<NavigatorState> rootNavigationKey =
      Get.nestedKey(getKey())!;

  static final GlobalKey<NavigatorState> mainNavigationKey =
      Get.nestedKey(getKey())!;

  static int getKey() {
    return keyAcc++;
  }
}
