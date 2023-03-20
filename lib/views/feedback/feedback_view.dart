import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/constants/text_styles.dart';
import 'package:flutter_application/views/feedback/feedback_controller.dart';
import 'package:get/get.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedbackController>(
        init: FeedbackController(),
        builder: (model) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('Обратная связь'),
                shadowColor: Colors.transparent,
                backgroundColor: Pallete.blue,
                leading: BackButton(
                  onPressed: () {},
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
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
                                SizedBox(height: 10),
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
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 12),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
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
