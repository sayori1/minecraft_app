import 'package:flutter_application/api/game.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/repositories/liked_repository.dart';
import 'package:flutter_application/views/main/main_controller.dart';
import 'package:flutter_application/views/root/root_controller.dart';
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
    likedGames = await Future.wait(likes.map((e) => GameAPI.get(e)).toList());
    isBusy = false.obs;
    update();
  }

  void onTapGame(Game game) async {
    await Get.find<RootController>().goToTab(0);
    await Future.delayed(100.milliseconds);
    await Get.toNamed(AppLinks.selectedGame, id: 1, arguments: game);
  }
}
