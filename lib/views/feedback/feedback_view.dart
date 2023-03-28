import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/constants/text_styles.dart';
import 'package:flutter_application/services/ad_service.dart';
import 'package:flutter_application/views/feedback/feedback_controller.dart';
import 'package:flutter_application/views/root/root_controller.dart';
import 'package:get/get.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedbackController>(
        key: key,
        init: FeedbackController(),
        builder: (model) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Обратная связь'),
                shadowColor: Colors.transparent,
                backgroundColor: Pallete.blue,
                leading: BackButton(
                  onPressed: () {
                    Get.find<RootController>().goToTab(0);
                  },
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Напишите нам',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.interSemiBold16),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(height: 10),
                                TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  minLines: 1,
                                  autofocus: true,
                                  controller: model.emailText,
                                  decoration: InputDecoration(
                                    hintText: 'Ваш e-mail',
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 12),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  minLines: 5,
                                  autofocus: true,
                                  controller: model.feedBackText,
                                  decoration: InputDecoration(
                                    hintText: 'Что вы хотели сказать?',
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 12),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                MaterialButton(
                                  height: 50,
                                  color: Pallete.blue,
                                  onPressed: model.sendFeedback,
                                  child: const Text(
                                    'Отправить',
                                    style: TextStyle(
                                      color: Pallete.white,
                                    ),
                                  ),
                                ),
                              ])
                        ],
                      )),
                    ),
                  ],
                ),
              ));
        });
  }
}
