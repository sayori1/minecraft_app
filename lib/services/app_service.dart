import 'dart:developer';
import 'dart:io';

import 'package:appcheck/appcheck.dart';
import 'package:flutter/material.dart';

class AppService {
  static List<AppInfo> installedApps = [];
  static AppInfo? minecraft;
  static Future<void> fetchApps() async {
    if (Platform.isAndroid) {
      installedApps = await AppCheck.getInstalledApps() ?? [];
      installedApps.sort(
        (a, b) => a.appName!.toLowerCase().compareTo(b.appName!.toLowerCase()),
      );
    } else if (Platform.isIOS) {
      // iOS doesn't allow to get installed apps.
    }
    for (int i = 0; i < installedApps.length; i++) {
      if (installedApps[i].packageName.split('.').contains('mojang')) {
        minecraft = installedApps[i];
      }
    }
  }
}
