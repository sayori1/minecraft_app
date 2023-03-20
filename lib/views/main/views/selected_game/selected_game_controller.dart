import 'package:flutter/material.dart';
import 'package:flutter_application/api/game.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/repositories/dowloaded_repository.dart';
import 'package:flutter_application/repositories/liked_repository.dart';
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
}
