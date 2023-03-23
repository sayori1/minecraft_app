import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/api/game.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/repositories/dowloaded_repository.dart';
import 'package:flutter_application/repositories/liked_repository.dart';
import 'package:flutter_application/services/ad_service.dart';
import 'package:flutter_application/services/app_service.dart';
import 'package:flutter_application/services/downloader_service.dart';
import 'package:flutter_application/utils/getx_base_view_model.dart';
import 'package:flutter_application/views/main/views/selected_game/views/downloaded_dialog_view.dart';
import 'package:flutter_application/views/main/views/selected_game/views/feedback_dialog_view.dart';
import 'package:flutter_application/views/main/views/selected_game/views/rating_dialog_view.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class SelectedGameController extends GetxBaseViewModel {
  Game game;
  RxBool isLiked = RxBool(false);
  RxBool isDownloaded = RxBool(false);
  RxBool isJustDownloaded = RxBool(false);
  RxBool isRated = RxBool(false);

  TextEditingController feedbackText = TextEditingController();

  Widget? ad;
  Widget? dialogAd;

  SelectedGameController({required this.game});

  @override
  void onInit() async {
    super.onInit();

    runFuture(() async {
      ad = await Get.find<AdService>().asyncNativeAd();
      isLiked.value = await LikedRepository.isLiked(game.id.toString());
      isDownloaded.value = await DownloaderService.isDownloaded(game.file.url);
      isRated.value = await RatedRepository.isRated(game.id.toString());

      game = await GameAPI.get(game.id.toString());
      dialogAd = await Get.find<AdService>().asyncNativeAd();
      update();
    });
  }

  void showFeedbackDialog() async {
    Get.dialog(
      const FeedbackDialog(),
    );
  }

  void showRatingDialog() {
    Get.dialog(
      const RatingDialog(),
    );
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
      isDownloaded.value = true;
      isJustDownloaded.value = true;
      GameAPI.install(game.id.toString());
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

  void sendRating() {
    Get.back();
    Get.snackbar('Ваша оценка учтена!', '',
        backgroundColor: Colors.white, duration: 3.seconds);
    RatedRepository.addRated(game.id.toString());
    isRated.value = true;
  }

  void sendFeedback() {
    Get.back();
    if (feedbackText.text.isNotEmpty) {
      GameAPI.report(game.id.toString(), feedbackText.text,
          AppService.minecraft?.versionName ?? 'not installed');
    }
    Get.snackbar('Отправлено!', '',
        backgroundColor: Colors.white, duration: 3.seconds);
  }
}
