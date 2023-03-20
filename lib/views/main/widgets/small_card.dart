import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/constants/text_styles.dart';
import 'package:flutter_application/widgets/icon_with_number.dart';

class SmallCard extends StatelessWidget {
  final String title;
  final String category;
  final int downloads;
  final double grade;
  final String size;
  final String version;
  final String image;
  final Function onTap;

  const SmallCard(
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
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppTextStyles.interRegular16
                      .copyWith(color: Pallete.blue),
                  maxLines: 1,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Image.network(
                image,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconWithNumber(
                    icon: 'assets/icons/download2.svg',
                    number: downloads.toString()),
                IconWithNumber(
                    icon: 'assets/icons/favorites.svg',
                    number: grade.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
