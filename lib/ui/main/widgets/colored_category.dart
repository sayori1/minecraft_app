import 'package:flutter/material.dart';
import 'package:flutter_application/constants/colors.dart';
import 'package:flutter_application/constants/text_styles.dart';

class ColoredCategory extends StatelessWidget {
  final String categoryName;
  final List<Widget> children;

  final String? buttonText;
  final Function? onTap;

  final int horizontalCount;

  ColoredCategory({
    required this.categoryName,
    required this.children,
    this.buttonText,
    this.onTap,
    this.horizontalCount = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Pallete.blue,
            height: 50,
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(categoryName,
                    style: AppTextStyles.interRegular16.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white)),
                if (buttonText != null)
                  MaterialButton(
                    color: Pallete.white,
                    onPressed: () => onTap!(),
                    child: Text(
                      buttonText!,
                      style: TextStyle(
                        color: Pallete.blue,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          if (horizontalCount == 1)
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: children.map((child) {
                return child;
              }).toList(),
            )
          else
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
