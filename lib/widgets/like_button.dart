import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LikeButton extends StatefulWidget {
  final bool isLiked;
  final Function(bool) onTap;

  const LikeButton({super.key, this.isLiked = false, required this.onTap});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;
  @override
  void initState() {
    isLiked = widget.isLiked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          setState(() {
            isLiked = !widget.isLiked;
            widget.onTap(widget.isLiked);
          });
        },
        icon: SvgPicture.asset(widget.isLiked
            ? 'assets/icons/heart_red.svg'
            : 'assets/icons/heart_border.svg'));
  }
}
