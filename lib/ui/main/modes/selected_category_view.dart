import 'package:flutter/material.dart';
import 'package:flutter_application/ui/main/main_controller.dart';
import 'package:flutter_application/ui/main/widgets/card.dart';
import 'package:flutter_application/utils/utils.dart';
import 'package:get/get.dart';

class SelectedCategoryView extends StatelessWidget {
  const SelectedCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (model) {
      List<Widget> children = model.selectedCategory!.gamesTop
          .map((e) => AppCard(
              onTap: () => model.goToGame(e),
              image: e.logo,
              title: e.title,
              category: e.type,
              downloads: e.installAmount,
              grade: e.rating.toDouble(),
              size: Utils.bytesToMegabytes(e.file.size).toString() + ' MB',
              version: 'VER: 1,5'))
          .toList();

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(model.selectedCategory!.title),
          leading: BackButton(
            onPressed: () {
              model.changeMode(mode.preview);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: children.map((child) {
              return child;
            }).toList(),
          ),
        ),
      );
    });
  }
}
