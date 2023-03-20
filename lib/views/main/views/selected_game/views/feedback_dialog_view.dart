import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/constants/text_styles.dart';
import 'package:flutter_application/views/main/views/selected_game/selected_game_controller.dart';
import 'package:get/get.dart';

class FeedbackDialog extends StatelessWidget {
  const FeedbackDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectedGameController>(
        autoRemove: false,
        builder: (model) {
          return Center(
            child: SizedBox(
              width: 300,
              height: 242,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: const Color(0xFFEAF4FF),
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
                          const SizedBox(height: 10),
                          TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            minLines: 5,
                            controller: model.feedbackText,
                            decoration: InputDecoration(
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
                            onPressed: () => {},
                            child: const Text(
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
          );
        });
  }
}
