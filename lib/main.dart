import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/services/downloader_service.dart';
import 'package:flutter_application/ui/root/root_view.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';

import 'dart:async';

Future<void> main() async {
  await init();
  runApp(const MyApp());
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(DownloaderService());
  Get.config(
    defaultPopGesture: true,
    enableLog: true,
    defaultOpaqueRoute: true,
    defaultTransition: Transition.cupertino,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App',
      home: const RootView(),
      enableLog: true,
      theme: ThemeData(
        brightness: Brightness.light,
        canvasColor: AppColors.canvasColor,
        highlightColor: AppColors.highlightColor,
        splashColor: AppColors.splashColor,
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Stack(
            children: [
              child!,
            ],
          ),
        );
      },
    );
  }
}
