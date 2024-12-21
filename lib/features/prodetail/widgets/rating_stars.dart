// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class RatingStars extends StatelessWidget {
  final int rating;
  final int maxRating;
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final bool interactive;
  final Function(int)? onRatingChanged;

  const RatingStars({
    Key? key,
    required this.rating,
    this.maxRating = 5,
    this.size = 24.0,
    this.activeColor = AppColors.primary,
    this.inactiveColor = Colors.grey,
    this.interactive = false,
    this.onRatingChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        return GestureDetector(
          onTap: interactive
              ? () {
                  if (onRatingChanged != null) {
                    onRatingChanged!(index + 1);
                  }
                }
              : null,
          child: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: index < rating ? activeColor : inactiveColor,
            size: size,
          ),
        );
      }),
    );
  }
}