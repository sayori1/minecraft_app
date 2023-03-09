import 'package:flutter/material.dart';
import 'package:flutter_application/ui/likes/likes_controller.dart';
import 'package:get/get.dart';

class LikesView extends StatelessWidget {
  const LikesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LikesController>(
        init: LikesController(),
        builder: (model) {
          return Scaffold(
              body: Stack(
            children: const [],
          ));
        });
  }
}
