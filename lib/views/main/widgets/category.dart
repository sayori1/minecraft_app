import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/constants/text_styles.dart';

class AppCategory extends StatelessWidget {
  final String categoryName;
  final List<Widget> children;

  final String buttonText;
  final Function onTap;

  final int horizontalCount;

  const AppCategory({
    super.key,
    required this.categoryName,
    required this.children,
    required this.buttonText,
    required this.onTap,
    this.horizontalCount = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(categoryName,
                  style: AppTextStyles.interRegular16
                      .copyWith(fontWeight: FontWeight.w600)),
              MaterialButton(
                color: Pallete.blue,
                onPressed: () => onTap(),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          if (horizontalCount == 1)
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: children.map((child) {
                return child;
              }).toList(),
            )
          else
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: horizontalCount,
              children: children.map((child) {
                return child;
              }).toList(),
            ),
        ],
      ),
    );
  }
}
