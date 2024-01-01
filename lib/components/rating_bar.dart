import 'package:flutter/material.dart';
import '../theme/colors.dart' as futa_map_colors;

typedef RatingChangeCallback = void Function(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;
  final double size;

  const StarRating({
    super.key,
    this.starCount = 5,
    required this.rating,
    required this.onRatingChanged,
    this.color = futa_map_colors.Colors.yellow,
    this.size = 24,
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        size: size,
        color: futa_map_colors.Colors.onBackground,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        size: size,
        color: color,
      );
    } else {
      icon = Icon(
        Icons.star,
        size: size,
        color: color,
      );
    }
    return InkResponse(
      onTap: () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(starCount, (index) => buildStar(context, index)),
    );
  }
}
