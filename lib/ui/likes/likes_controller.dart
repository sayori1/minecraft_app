import 'dart:developer';

import 'package:flutter_application/api/game.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/repositories/liked_repository.dart';
import 'package:get/get.dart';

class LikesController extends GetxController {
  List<String> likes = [];
  List<Game> likedGames = [];

  RxBool isBusy = false.obs;

  @override
  void onInit() async {
    await load();
    super.onInit();
  }

  Future load() async {
    isBusy = true.obs;
    likes = await LikedRepository.getList();
    likedGames =
        await Future.wait(likes.map((e) => GameApi.getGame(e)).toList());
    isBusy = false.obs;
    update();
  }
}
