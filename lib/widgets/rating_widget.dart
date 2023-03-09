import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  final double initialRating;
  final Function(double) onRatingChanged;
  final double size;

  RatingWidget(
      {this.initialRating = 0,
      required this.onRatingChanged,
      required this.size});

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _rating = index + 1.0;
            });
            widget.onRatingChanged(_rating);
          },
          child: Icon(
            index < _rating.floor()
                ? Icons.star
                : index == _rating.floor() && _rating != _rating.floor()
                    ? Icons.star_half
                    : Icons.star_border,
            size: widget.size,
            color: Colors.yellow,
          ),
        );
      }),
    );
  }
}
