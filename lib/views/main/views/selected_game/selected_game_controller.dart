import 'package:flutter/material.dart';
import 'package:flutter_application/api/game.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/repositories/dowloaded_repository.dart';
import 'package:flutter_application/repositories/liked_repository.dart';
import 'package:flutter_application/services/downloader_service.dart';
import 'package:flutter_application/views/main/views/selected_game/views/downloaded_dialog_view.dart';
import 'package:flutter_application/views/main/views/selected_game/views/feedback_dialog_view.dart';
import 'package:flutter_application/views/main/views/selected_game/views/rating_dialog_view.dart';
import 'package:get/get.dart';

class SelectedGameController extends GetxController {
  Game game;
  RxBool isLiked = RxBool(false);
  RxBool isDownloaded = RxBool(false);
  TextEditingController feedbackText = TextEditingController();

  SelectedGameController({required this.game});

  @override
  void onInit() async {
    isLiked.value = await LikedRepository.isLiked(game.id.toString());
    isDownloaded.value =
        await DownloadRepository.isDownloaded(game.id.toString());

    game = await GameAPI.get(game.id.toString());
    update();
    super.onInit();
  }

  void showFeedbackDialog() {
    Get.dialog(
      const FeedbackDialog(),
    );
  }

  void showRatingDialog() {
    Get.dialog(
      const RatingDialog(),
    );
  }

  Future<void> showDownloadDialog() async {
    Get.find<DownloaderService>()
        .startDownloading(game.file.url, game.id.toString());
    bool result = await Get.dialog(
      const DownloadDialog(),
    );
    if (result) {
      Get.find<SelectedGameController>().isDownloaded.value = true;
      DownloadRepository.addDownloaded(
          Get.find<SelectedGameController>().game.id.toString());
    }
  }

  Future<void> openInMinecraft() async {}
}
