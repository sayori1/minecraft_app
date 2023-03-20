import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/views/likes/likes_controller.dart';
import 'package:flutter_application/views/main/widgets/small_card.dart';
import 'package:flutter_application/utils/utils.dart';
import 'package:get/get.dart';

class LikesView extends StatelessWidget {
  const LikesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LikesController>(
        key: key,
        init: LikesController(),
        builder: (model) {
          List<Widget> children = model.likedGames
              .map((e) => SmallCard(
                  onTap: () => model.onTapGame(e),
                  downloads: e.installAmount,
                  image: e.logo,
                  title: e.title,
                  category: e.type,
                  grade: e.rating.toDouble(),
                  size: '${Utils.bytesToMegabytes(e.file.size)} MB',
                  version: 'VER: 1,5'))
              .toList();

          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Избранное'),
                shadowColor: Colors.transparent,
                backgroundColor: Pallete.blue,
                leading: BackButton(
                  onPressed: () {},
                ),
              ),
              body: model.isBusy.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Stack(
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            Expanded(
                              child: SingleChildScrollView(
                                child: GridView.count(
                                  crossAxisSpacing: 10,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  crossAxisCount: 2,
                                  children: children,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ));
        });
  }
}
