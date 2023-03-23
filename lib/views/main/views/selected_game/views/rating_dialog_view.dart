import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/constants/text_styles.dart';
import 'package:flutter_application/views/main/views/selected_game/selected_game_controller.dart';
import 'package:flutter_application/widgets/rating_widget.dart';
import 'package:get/get.dart';

class RatingDialog extends StatelessWidget {
  const RatingDialog({
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
              height: 172,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                          const SizedBox(height: 10),
                          Center(
                              child: RatingWidget(
                                  onRatingChanged: (double t) {}, size: 50)),
                          const SizedBox(height: 10),
                          MaterialButton(
                            height: 50,
                            color: Pallete.blue,
                            onPressed: () => {model.sendRating()},
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
