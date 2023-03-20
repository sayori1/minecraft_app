import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/constants/text_styles.dart';
import 'package:flutter_application/services/downloader_service.dart';
import 'package:flutter_application/utils/utils.dart';
import 'package:flutter_application/views/main/main_controller.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';

class DownloadDialog extends StatelessWidget {
  const DownloadDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DownloaderService>(builder: (model) {
      return Center(
        child: Container(
          width: 300,
          height: 172,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (model.status.value == DownloadTaskStatus.complete)
                        completedState(model)
                      else
                        downloadingState(model)
                    ]),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget downloadingState(DownloaderService model) {
    return Column(children: [
      Text(
        'Скачивание...',
        style: AppTextStyles.interSemiBold16,
        textAlign: TextAlign.left,
      ),
      const SizedBox(height: 10),
      Text(
        "${Utils.bytesToMegabytes(Get.find<MainController>().selectedGame!.file.size)} MB",
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
    return Column(children: [
      Text(
        'Скачано',
        style: AppTextStyles.interSemiBold16,
        textAlign: TextAlign.left,
      ),
      const SizedBox(height: 10),
      Text(
        "${Utils.bytesToMegabytes(Get.find<MainController>().selectedGame!.file.size)} MB",
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
