import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {

  final int rating;
  final double starSize;

  const RatingStars({super.key, required this.rating, this.starSize = 18.0});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Container(
          margin: const EdgeInsets.only(right: 5),
          child: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: index < rating ? Colors.amber : Colors.black54,
            size: starSize,
          ),
        );
      }),
    );
  }
}