import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/api/game.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/repositories/dowloaded_repository.dart';
import 'package:flutter_application/repositories/liked_repository.dart';
import 'package:flutter_application/services/app_service.dart';
import 'package:flutter_application/services/downloader_service.dart';
import 'package:flutter_application/views/main/views/selected_game/views/downloaded_dialog_view.dart';
import 'package:flutter_application/views/main/views/selected_game/views/feedback_dialog_view.dart';
import 'package:flutter_application/views/main/views/selected_game/views/rating_dialog_view.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class SelectedGameController extends GetxController {
  Game game;
  RxBool isLiked = RxBool(false);
  RxBool isDownloaded = RxBool(false);
  TextEditingController feedbackText = TextEditingController();

  SelectedGameController({required this.game});

  @override
  void onInit() async {
    isLiked.value = await LikedRepository.isLiked(game.id.toString());
    isDownloaded.value = await DownloaderService.isDownloaded(game.file.url);

    game = await GameAPI.get(game.id.toString());
    update();
    super.onInit();
  }

  void showFeedbackDialog() async {
    await Get.dialog(
      const FeedbackDialog(),
    );
    if (feedbackText.text.isNotEmpty) {
      GameAPI.report(game.id.toString(), feedbackText.text,
          AppService.minecraft?.versionName ?? 'not installed');
    }
  }

  void likeButtonTap(bool value) {
    if (value) {
      LikedRepository.addLiked(game.id.toString());
    }
    if (!value) {
      LikedRepository.deleteLiked(game.id.toString());
    }
    GameAPI.like(game.id.toString());
    isLiked.value = value;
  }

  void showRatingDialog() {
    Get.dialog(
      const RatingDialog(),
    );
  }

  String getFileName() {
    List<String> parts = game.file.url.split('.');
    String fileName =
        parts[parts.length - 2].split('/').last + game.id.toString();
    String extension = parts[parts.length - 1];
    return fileName + '.' + extension;
  }

  Future<void> showDownloadDialog() async {
    Get.find<DownloaderService>()
        .startDownloading(game.file.url, getFileName());
    bool result = await Get.dialog(
      const DownloadDialog(),
    );
    if (result) {
      Get.find<SelectedGameController>().isDownloaded.value = true;
      GameAPI.install(game.id.toString());
      DownloadRepository.addDownloaded(
          Get.find<SelectedGameController>().game.id.toString());
    }
  }

  Future<void> openInMinecraft() async {
    if (AppService.minecraft == null) {
      Get.snackbar('Ошибка',
          'На вашем устройстве не установлен Minecraft PE, либо его версия устарела. Пожалуйста, установите игру и попробуйте снова',
          backgroundColor: Colors.white, duration: 10.seconds);
    } else {
      DownloaderService.open(game.file.url);
    }
  }
}
