// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/constants/text_styles.dart';
import 'package:flutter_application/main.dart';
import 'package:flutter_application/models/base/game.dart';
import 'package:flutter_application/repositories/dowloaded_repository.dart';
import 'package:flutter_application/repositories/liked_repository.dart';
import 'package:flutter_application/services/downloader_service.dart';
import 'package:flutter_application/views/main/common.dart';
import 'package:flutter_application/views/main/main_controller.dart';
import 'package:flutter_application/views/main/views/selected_game/selected_game_controller.dart';
import 'package:flutter_application/views/main/views/selected_game/views/feedback_dialog_view.dart';
import 'package:flutter_application/views/main/views/selected_game/views/rating_dialog_view.dart';
import 'package:flutter_application/views/main/widgets/card.dart';
import 'package:flutter_application/views/main/widgets/colored_category.dart';
import 'package:flutter_application/utils/utils.dart';
import 'package:flutter_application/widgets/like_button.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'views/downloaded_dialog_view.dart';

class SelectedGameView extends StatelessWidget {
  final Game game;

  const SelectedGameView({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectedGameController>(
        autoRemove: false,
        init: SelectedGameController(game: game),
        builder: (model) {
/*           if (false) {
            return const Center(
                child: Padding(
              padding: EdgeInsets.only(top: 200),
              child: CircularProgressIndicator(),
            ));
          } */

          Widget card = AppCard(
              onTap: () => {},
              image: model.game.logo,
              title: model.game.title,
              category: model.game.type,
              downloads: model.game.installAmount,
              grade: model.game.rating.toDouble(),
              size: '${Utils.bytesToMegabytes(model.game.file.size)} MB',
              version: 'VER: 1,5');

          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(model.game.title),
                leading: BackButton(
                  onPressed: () {
                    Get.back(id: 1);
                  },
                ),
                actions: [
                  LikeButton(
                      isLiked: model.isLiked.value,
                      onTap: (bool value) {
                        if (value) {
                          LikedRepository.addLiked(model.game.id.toString());
                        }
                        if (!value) {
                          LikedRepository.deleteLiked(model.game.id.toString());
                        }
                      })
                ],
              ),
              body: SingleChildScrollView(
                  child: Obx(() => (model.isDownloaded.value)
                      ? downloadedState()
                      : defaultState(card, model))));
        });
  }

  Column defaultState(Widget card, SelectedGameController model) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                card,
                MaterialButton(
                  color: Pallete.blue,
                  onPressed: () {
                    Get.find<DownloaderService>()
                        .startDownloading(model.game.file.url);
                    showDownloadDialog();
                  },
                  child: const Text(
                    'Установить',
                    style: TextStyle(
                      color: Pallete.white,
                    ),
                  ),
                ),
                MaterialButton(
                  color: Pallete.white,
                  onPressed: () => showRatingDialog(),
                  child: const Text(
                    'Оценить приложение',
                    style: TextStyle(
                      color: Pallete.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (model.game.description != null)
                  Html(data: model.game.description!),
                MaterialButton(
                  color: Pallete.red,
                  onPressed: () => showFeedbackDialog(model),
                  child: const Text(
                    'Не работает карта/мод/скин?',
                    style: TextStyle(
                      color: Pallete.white,
                    ),
                  ),
                ),
              ],
            )),
        ColoredCategory(
            horizontalCount: 2,
            categoryName: 'Похожее',
            children: game.similars
                .map((e) => Common.smallGameCard(
                    game,
                    (game) => Get.toNamed(AppLinks.selectedGame,
                        id: 1, arguments: game)))
                .toList())
      ],
    );
  }

  Container downloadedState() {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: 10),
          Text('Успешно загружено',
              style: AppTextStyles.interSemiBold16,
              textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Align(
              child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                      color: Pallete.blue, shape: BoxShape.circle),
                  child: SvgPicture.asset('assets/icons/done.svg',
                      width: 50, height: 50))),
          const SizedBox(height: 20),
          Text('Нажмите, чтобы открыть в Minecraft',
              style: AppTextStyles.interRegular16, textAlign: TextAlign.center),
          const SizedBox(height: 10),
          MaterialButton(
            color: Pallete.blue,
            onPressed: () {},
            child: const Text(
              'Открыть в Minecraft',
              style: TextStyle(
                color: Pallete.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ]));
  }

  void showFeedbackDialog(SelectedGameController model) {
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
    bool result = await Get.dialog(
      const DownloadDialog(),
    );
    if (result) {
      Get.find<MainController>().isDownloaded.value = true;
      DownloadRepository.addDownloaded(
          Get.find<MainController>().selectedGame!.id.toString());
    }
  }
}
