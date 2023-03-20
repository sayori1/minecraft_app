import 'package:flutter/material.dart';
import 'package:flutter_application/api/application.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/models/base/category.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/models/responses/main.dart';
import 'package:flutter_application/repositories/dowloaded_repository.dart';
import 'package:flutter_application/repositories/liked_repository.dart';
import 'package:get/get.dart';

enum MODE { preview, categories, selectedCategory, selectedGame }

class MainController extends GetxController {
  List<Enum> navigationStack = [MODE.preview];

  MainResponse? response;

  Category? selectedCategory;

  Game? selectedGame;
  RxBool isDownloaded = RxBool(false);
  RxBool isLiked = RxBool(false);
  TextEditingController feedBackText = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    response = await ApplicationAPI.getMain();
    update();
  }

  void goTo(Enum mode, {addToStack = true}) {
    if (addToStack) navigationStack.add(mode);
    if (mode == MODE.preview) Get.toNamed(AppLinks.preview, id: 1);
    if (mode == MODE.categories) Get.toNamed(AppLinks.categories, id: 1);
    if (mode == MODE.selectedCategory) {
      Get.toNamed(AppLinks.selectedCategory, id: 1);
    }
    if (mode == MODE.selectedGame) Get.toNamed(AppLinks.selectedGame, id: 1);
  }

  void back() {
    navigationStack.removeLast();
    if (navigationStack.isNotEmpty) {
      goTo(navigationStack.last, addToStack: false);
    } else {
      goTo(MODE.preview, addToStack: false);
    }
  }

  void goToGame(Game game) async {
    isDownloaded.value = false;
    isLiked.value = false;

    if (await DownloadRepository.isDownloaded(game.id.toString())) {
      isDownloaded.value = true;
    }

    if (await LikedRepository.isLiked(game.id.toString())) {
      isLiked.value = true;
    }

    selectedGame = game;
    goTo(MODE.selectedGame);
    update();
  }

  void sendFeedback() {}

  void sendLike() {}
}
