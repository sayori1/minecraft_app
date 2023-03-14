import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/constants/text_styles.dart';
import 'package:flutter_application/repositories/dowloaded_repository.dart';
import 'package:flutter_application/repositories/liked_repository.dart';
import 'package:flutter_application/services/downloader_service.dart';
import 'package:flutter_application/ui/main/main_controller.dart';
import 'package:flutter_application/ui/main/widgets/card.dart';
import 'package:flutter_application/ui/main/widgets/colored_category.dart';
import 'package:flutter_application/utils/utils.dart';
import 'package:flutter_application/widgets/rating_widget.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SelectedGameView extends StatelessWidget {
  const SelectedGameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (model) {
      Widget card = AppCard(
          onTap: () => {},
          image: model.selectedGame!.logo,
          title: model.selectedGame!.title,
          category: model.selectedGame!.type,
          downloads: model.selectedGame!.installAmount,
          grade: model.selectedGame!.rating.toDouble(),
          size:
              Utils.bytesToMegabytes(model.selectedGame!.file.size).toString() +
                  ' MB',
          version: 'VER: 1,5');
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(model.selectedGame!.title),
            leading: BackButton(
              onPressed: () {
                model.changeMode(mode.preview);
              },
            ),
            actions: [
              LikeButton(
                  isLiked: model.isLiked.value,
                  onTap: (bool value) {
                    if (value)
                      LikedRepository.addLiked(
                          model.selectedGame!.id.toString());
                    if (!value)
                      LikedRepository.deleteLiked(
                          model.selectedGame!.id.toString());
                  })
            ],
          ),
          body: SingleChildScrollView(
              child: Obx(() => (!model.isDownloaded.value)
                  ? Column(
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
                                        .startDownloading(
                                            model.selectedGame!.file.url);
                                    showDownloadDialog();
                                  },
                                  child: Text(
                                    'Установить',
                                    style: TextStyle(
                                      color: Pallete.white,
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  color: Pallete.white,
                                  onPressed: () => showRatingDialog(),
                                  child: Text(
                                    'Оценить приложение',
                                    style: TextStyle(
                                      color: Pallete.blue,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(model.selectedGame!.description ??
                                    "Пустое описание"),
                                MaterialButton(
                                  color: Pallete.red,
                                  onPressed: () => showFeedbackDialog(),
                                  child: Text(
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
                            children: [])
                      ],
                    )
                  : downloadedCard())));
    });
  }

  Container downloadedCard() {
    return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(height: 10),
          Text('Успешно загружено',
              style: AppTextStyles.interSemiBold16,
              textAlign: TextAlign.center),
          SizedBox(height: 20),
          Align(
              child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Pallete.blue, shape: BoxShape.circle),
                  child: SvgPicture.asset('assets/icons/done.svg',
                      width: 50, height: 50, color: Pallete.white))),
          SizedBox(height: 20),
          Text('Нажмите, чтобы открыть в Minecraft',
              style: AppTextStyles.interRegular16, textAlign: TextAlign.center),
          SizedBox(height: 10),
          MaterialButton(
            color: Pallete.blue,
            onPressed: () {},
            child: Text(
              'Открыть в Minecraft',
              style: TextStyle(
                color: Pallete.white,
              ),
            ),
          ),
          SizedBox(height: 10),
        ]));
  }

  void showFeedbackDialog() {
    Get.dialog(
      Center(
        child: Container(
          width: 300,
          height: 242,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color(0xFFEAF4FF),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Пожалуйста, опишите проблему',
                        style: AppTextStyles.interRegular16,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 5,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 12),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      MaterialButton(
                        height: 50,
                        color: Pallete.blue,
                        onPressed: () => {},
                        child: Text(
                          'Отправить',
                          style: TextStyle(
                            color: Pallete.white,
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showRatingDialog() {
    Get.dialog(
      Center(
        child: Container(
          width: 300,
          height: 172,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Оцените приложение',
                        style: AppTextStyles.interRegular16,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Center(
                          child: RatingWidget(
                              onRatingChanged: (double t) {}, size: 50)),
                      SizedBox(height: 10),
                      MaterialButton(
                        height: 50,
                        color: Pallete.blue,
                        onPressed: () => {},
                        child: Text(
                          'Отправить',
                          style: TextStyle(
                            color: Pallete.white,
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showDownloadDialog() async {
    bool result = await Get.dialog(
      DownloadDialog(),
    );
    if (result) {
      Get.find<MainController>().isDownloaded.value = true;
      DownloadRepository.addDownloaded(
          Get.find<MainController>().selectedGame!.id.toString());
    }
  }
}

class LikeButton extends StatefulWidget {
  bool isLiked = false;
  Function(bool) onTap;

  LikeButton({Key? key, this.isLiked = false, required this.onTap})
      : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            widget.isLiked = !widget.isLiked;
            widget.onTap(widget.isLiked);
          });
        },
        icon: SvgPicture.asset(widget.isLiked
            ? 'assets/icons/heart_red.svg'
            : 'assets/icons/heart_border.svg'));
  }
}

class DownloadDialog extends StatelessWidget {
  DownloadDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DownloaderService>(builder: (model) {
      return Center(
        child: Container(
          width: 300,
          height: 172,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (model.status.value == DownloadTaskStatus.complete)
                        ...completedStatus(model)
                      else
                        ...downloadingStatus(model)
                    ]),
              ),
            ),
          ),
        ),
      );
    });
  }

  List<Widget> downloadingStatus(DownloaderService model) {
    return [
      Text(
        'Скачивание...',
        style: AppTextStyles.interSemiBold16,
        textAlign: TextAlign.left,
      ),
      const SizedBox(height: 10),
      Text(
        Utils.bytesToMegabytes(
                    Get.find<MainController>().selectedGame!.file!.size)
                .toString() +
            " MB",
        style: AppTextStyles.interSemiBold16.copyWith(color: Pallete.blue),
        textAlign: TextAlign.right,
      ),
      const SizedBox(height: 30),
      LinearProgressIndicator(value: (model.step.value / 100).toDouble()),
      const SizedBox(height: 20),
      Align(
        alignment: Alignment.bottomRight,
        child: MaterialButton(
          height: 30,
          onPressed: () async {
            model.stopDownloading();
            Get.back(result: false);
          },
          child: Text(
            'Отмена',
            style: AppTextStyles.interSemiBold16.copyWith(color: Pallete.blue),
          ),
        ),
      ),
    ];
  }

  List<Widget> completedStatus(DownloaderService model) {
    return [
      Text(
        'Скачано',
        style: AppTextStyles.interSemiBold16,
        textAlign: TextAlign.left,
      ),
      const SizedBox(height: 10),
      Text(
        Utils.bytesToMegabytes(
                    Get.find<MainController>().selectedGame!.file!.size)
                .toString() +
            " MB",
        style: AppTextStyles.interSemiBold16.copyWith(color: Pallete.blue),
        textAlign: TextAlign.right,
      ),
      const SizedBox(height: 30),
      LinearProgressIndicator(value: 1),
      const SizedBox(height: 20),
      Align(
        alignment: Alignment.bottomRight,
        child: MaterialButton(
          height: 30,
          onPressed: () async {
            Get.back(result: true);
          },
          child: Text(
            'ОК',
            style: AppTextStyles.interSemiBold16.copyWith(color: Pallete.blue),
          ),
        ),
      ),
    ];
  }
}
