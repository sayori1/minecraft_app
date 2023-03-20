import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/constants/text_styles.dart';
import 'package:flutter_svg/svg.dart';

class IconWithNumber extends StatelessWidget {
  final String icon;
  final String number;

  const IconWithNumber({super.key, required this.icon, required this.number});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon, width: 20),
        const SizedBox(width: 5.0),
        Text(
          number,
          style: AppTextStyles.interRegular16.copyWith(color: Pallete.blue),
        ),
        const SizedBox(width: 13.0),
      ],
    );
  }
}
