import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/api/application.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/models/responses/main.dart';
import 'package:flutter_application/repositories/dowloaded_repository.dart';
import 'package:get/get.dart';

enum mode { preview, categories, selectedCategory, selectedGame }

class MainController extends GetxController {
  MainResponse? response;

  Category? selectedCategory;
  Game? selectedGame;
  Enum selectedMode = mode.preview;
  ValueNotifier<Enum> selectedModeNotifier = ValueNotifier<Enum>(mode.preview);

  RxBool isDownloaded = RxBool(false);

  @override
  void onInit() async {
    super.onInit();
    response = await ApplicationApi.getMain();
    update();
  }

  void changeMode(Enum mode) {
    selectedMode = mode;
    selectedModeNotifier.value = mode;
    update();
  }

  void goToGame(Game game) async {
    isDownloaded.value = false;

    if (await DownloadRepository.isDownloaded(game.title)) {
      isDownloaded.value = true;
    }

    selectedGame = game;
    selectedMode = mode.selectedGame;
    update();
  }
}
