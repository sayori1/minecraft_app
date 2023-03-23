import 'package:flutter/material.dart';
import 'package:flutter_application/api/game.dart';
import 'package:flutter_application/constants/keys.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/repositories/liked_repository.dart';
import 'package:flutter_application/services/ad_service.dart';
import 'package:flutter_application/utils/getx_base_view_model.dart';
import 'package:flutter_application/views/main/main_controller.dart';
import 'package:flutter_application/views/root/root_controller.dart';
import 'package:get/get.dart';

class LikesController extends GetxBaseViewModel {
  List<String> likes = [];
  List<Game> likedGames = [];
  Widget? ad;

  @override
  void onInit() async {
    await load();
    super.onInit();
  }

  Future load() async {
    runFuture(() async {
      ad = await Get.find<AdService>().asyncNativeAd();
      likes = await LikedRepository.getList();
      likedGames = await Future.wait(likes.map((e) => GameAPI.get(e)).toList());
    });
  }

  void onTapGame(Game game) async {
    Get.find<RootController>().goToGame(game);
  }
}
