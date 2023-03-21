import 'package:flutter/material.dart';
import 'package:flutter_application/api/game.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {
  TextEditingController feedBackText = TextEditingController();
  TextEditingController emailText = TextEditingController();

  Future<void> sendFeedback() async {
    if (feedBackText.text.isEmpty) return;
    await GameAPI.request(feedBackText.text);
    Get.snackbar('Сообщение отправлено!', '',
        backgroundColor: Colors.white, duration: 3.seconds);
  }
}
