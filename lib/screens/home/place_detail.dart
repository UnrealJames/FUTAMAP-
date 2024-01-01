import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:futamap/components/buttons.dart';
import 'package:futamap/components/rating_bar.dart';
import 'package:futamap/data/model/location.dart';
import 'package:futamap/screens/home/navigation.dart';
import '../../theme/colors.dart' as futa_map_colors;
import 'package:collection/collection.dart';

class PlaceDetailScreen extends StatefulWidget {
  const PlaceDetailScreen({super.key});
  static const routeName = '/placeDetailArguments';
  @override
  State<StatefulWidget> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  late double _deviceHeight, _deviceWidth;
  int currentPageIndex = 1;
  double rating = 0.0;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    final args = ModalRoute.of(context)!.settings.arguments as Location;
    return Scaffold(
      backgroundColor: futa_map_colors.Colors.background,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          iconSize: 30,
          tooltip: 'Back button',
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          SizedBox(
            width: _deviceWidth,
            height: _deviceHeight * .45,
            child: Container(
              color: Colors.blue,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  args.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Icon(
                  args.isFavorite
                      ? Icons.bookmark
                      : Icons.bookmark_border_outlined,
                  size: 30,
                  color: futa_map_colors.Colors.primary,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              args.description,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      args.rating.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: StarRating(
                        rating: args.rating,
                        onRatingChanged: (p0) => {},
                      ),
                    ),
                  ],
                ),
                defaultButton(
                  width: _deviceWidth * .25,
                  text: "Visit",
                  onPressed: () => {
                    Navigator.pushNamed(
                      context,
                      NavigationScreen.routeName,
                      arguments: args.latLng,
                    )
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: StaggeredGrid.count(
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              crossAxisCount: 3,
              children: args.images
                  .mapIndexed(
                    (i, e) => SizedBox(
                      height: 140,
                      child: Container(
                        decoration: BoxDecoration(
                          color: futa_map_colors.Colors.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Have you been here?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: const Text(
                  "How was your experience?",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 16),
                child: StarRating(
                    rating: rating,
                    size: 35,
                    onRatingChanged: (p0) => {setState(() => rating = p0)}),
              ),
              defaultButton(width: _deviceWidth * .7, text: "Rate"),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
