import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/constants/text_styles.dart';
import 'package:flutter_application/widgets/icon_with_number.dart';

class AppCard extends StatelessWidget {
  final String title;
  final String category;
  final int downloads;
  final double grade;
  final String size;
  final String version;
  final String image;
  final Function onTap;

  const AppCard(
      {super.key,
      required this.title,
      required this.category,
      required this.downloads,
      required this.grade,
      required this.size,
      required this.version,
      required this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: AppTextStyles.interRegular16
                      .copyWith(color: Pallete.blue),
                  maxLines: 1,
                ),
                const Spacer(),
                Container(
                  color: Pallete.blue2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      category,
                      textAlign: TextAlign.right,
                      style: AppTextStyles.interRegular16
                          .copyWith(color: Pallete.blue),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Image.network(
              image,
              width: double.infinity,
              height: 200.0,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    IconWithNumber(
                        icon: 'assets/icons/download2.svg',
                        number: downloads.toString()),
                    IconWithNumber(
                        icon: 'assets/icons/favorites.svg',
                        number: grade.toString()),
                    IconWithNumber(
                        icon: 'assets/icons/download.svg',
                        number: size.toString()),
                  ],
                ),
                const Spacer(),
                Text(version,
                    textAlign: TextAlign.right,
                    style: AppTextStyles.interRegular16
                        .copyWith(color: Pallete.blue)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
