import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/constants/text_styles.dart';
import 'package:flutter_application/services/downloader_service.dart';
import 'package:flutter_application/utils/utils.dart';
import 'package:flutter_application/views/main/views/selected_game/selected_game_controller.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';

class DownloadDialog extends StatefulWidget {
  const DownloadDialog({super.key});

  @override
  State<DownloadDialog> createState() => _DownloadDialogState();
}

class _DownloadDialogState extends State<DownloadDialog> {
  bool startDownloading = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DownloaderService>(builder: (model) {
      return Center(
        child: Container(
          width: Get.width - 40,
          height: startDownloading ? 340 : 300,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    body: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, right: 12.0, top: 12.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (!startDownloading)
                                defaultState(model)
                              else if (model.status.value ==
                                  DownloadTaskStatus.complete)
                                completedState(model)
                              else if (model.status.value ==
                                  DownloadTaskStatus.running)
                                downloadingState(model)
                            ]),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                    height: 160,
                    child: Scaffold(
                        body: Get.find<SelectedGameController>().dialogAd!))
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget defaultState(DownloaderService model) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(
        'Хотите установить?',
        style: AppTextStyles.interSemiBold16,
        textAlign: TextAlign.left,
      ),
      SizedBox(height: 20),
      MaterialButton(
        color: Pallete.blue,
        onPressed: () {
          var controller = Get.find<SelectedGameController>();
          setState(() {
            model.startDownloading(
                controller.game.file.url, controller.getFileName());
            startDownloading = true;
          });
        },
        child: const Text(
          'Установить',
          style: TextStyle(
            color: Pallete.white,
          ),
        ),
      )
    ]);
  }

  Widget downloadingState(DownloaderService model) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Скачивание...',
        style: AppTextStyles.interSemiBold16,
        textAlign: TextAlign.left,
      ),
      const SizedBox(height: 10),
      Text(
        "${Utils.bytesToMegabytes(Get.find<SelectedGameController>().game.file.size)} MB",
        style: AppTextStyles.interSemiBold16.copyWith(color: Pallete.blue),
        textAlign: TextAlign.right,
      ),
      const SizedBox(height: 30),
      LinearProgressIndicator(value: (model.step.value / 100).toDouble()),
      const SizedBox(height: 20),
      Align(
        alignment: Alignment.bottomRight,
        child: MaterialButton(
          height: 30,
          onPressed: () async {
            model.stopDownloading();
            Get.back(result: false);
          },
          child: Text(
            'Отмена',
            style: AppTextStyles.interSemiBold16.copyWith(color: Pallete.blue),
          ),
        ),
      ),
    ]);
  }

  Widget completedState(DownloaderService model) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Скачано',
        style: AppTextStyles.interSemiBold16,
        textAlign: TextAlign.left,
      ),
      const SizedBox(height: 10),
      Text(
        "${Utils.bytesToMegabytes(Get.find<SelectedGameController>().game.file.size)} MB",
        style: AppTextStyles.interSemiBold16.copyWith(color: Pallete.blue),
        textAlign: TextAlign.right,
      ),
      const SizedBox(height: 30),
      const LinearProgressIndicator(value: 1),
      const SizedBox(height: 20),
      Align(
        alignment: Alignment.bottomRight,
        child: MaterialButton(
          height: 30,
          onPressed: () async {
            Get.back(result: true);
          },
          child: Text(
            'ОК',
            style: AppTextStyles.interSemiBold16.copyWith(color: Pallete.blue),
          ),
        ),
      ),
    ]);
  }
}
