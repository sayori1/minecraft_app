import 'dart:io';

import 'package:appcheck/appcheck.dart';
import 'package:flutter/material.dart';

class AppsService {
  static List<AppInfo>? installedApps;
  static Future<void> fetchApps() async {
    List<AppInfo>? installedApps;

    if (Platform.isAndroid) {
      installedApps = await AppCheck.getInstalledApps();
      installedApps?.sort(
        (a, b) => a.appName!.toLowerCase().compareTo(b.appName!.toLowerCase()),
      );
    } else if (Platform.isIOS) {
      // iOS doesn't allow to get installed apps.
    }
    installedApps = installedApps;
  }
}
