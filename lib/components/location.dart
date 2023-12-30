import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:futamap/components/rating_bar.dart';
import 'package:futamap/data/model/location.dart';
import '../theme/colors.dart' as futa_map_colors;

Widget locationComponent({
  required Location location,
  required int index,
  onPress,
}) {
  return InkWell(
    onTap: () => onPress(location),
    child: Container(
      margin: EdgeInsets.only(
        right: (index % 2 == 0) ? 0 : 16,
        left: (index % 2 == 0) ? 16 : 0,
      ),
      padding: EdgeInsets.only(
        left: (index % 2 == 0) ? 0 : 8,
        right: (index % 2 == 0) ? 8 : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
            child: Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: futa_map_colors.Colors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: Text(
              location.name,
              selectionColor: Colors.black,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              location.description,
              selectionColor: Colors.black,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StarRating(
                    rating: location.rating, onRatingChanged: (p0) => {}),
                Text(
                  location.rating.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
