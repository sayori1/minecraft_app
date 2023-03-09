import 'package:flutter/material.dart';
import 'package:flutter_application/ui/feedback/feedback_controller.dart';
import 'package:get/get.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedbackController>(
        init: FeedbackController(),
        builder: (model) {
          return Scaffold(
              body: Stack(
            children: const [],
          ));
        });
  }
}
