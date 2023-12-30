import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:futamap/components/location.dart';
import 'package:futamap/data/model/location.dart';
import 'package:futamap/components/textfields.dart';
import 'package:futamap/screens/home/place_detail.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vector_graphics/vector_graphics.dart';
import '../../theme/colors.dart' as futa_map_colors;
import 'package:collection/collection.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  late double _deviceHeight, _deviceWidth;
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    var searchText = '';
    final locations = [
      Location(
        "FUTA Library",
        "",
        "Lorem ipsum dolor sit amet consectetur. Arcu tellus adipiscing rutrum sed eros venenatis et at. Sed fermentum ullamcorper urna habitant egestas. Netus turpis eu in parturient bibendum eget vitae. Tincidunt integer gravida dolor amet sed tellus amet ornare viverra. Nisl volutpat at a rhoncus urna et sed diam porta. Id pellentesque faucibus morbi.",
        ["assets/svgs/library.svg.vec", "assets/images/library.jpg", "", ""],
        4.5,
        const LatLng(7.305990571050196, 5.1397887288105),
        isFavorite: true,
      ),
      Location(
        "FUTA Library",
        "",
        "Lorem ipsum dolor sit amet consectetur. Arcu tellus adipiscing rutrum sed eros venenatis et at. Sed fermentum ullamcorper urna habitant egestas. Netus turpis eu in parturient bibendum eget vitae. Tincidunt integer gravida dolor amet sed tellus amet ornare viverra. Nisl volutpat at a rhoncus urna et sed diam porta. Id pellentesque faucibus morbi.",
        ["assets/svgs/library.svg.vec", "assets/images/library.jpg"],
        3.2,
        const LatLng(7.305990571050196, 5.1397887288105),
      ),
      Location(
        "FUTA Library",
        "",
        "Lorem ipsum dolor sit amet consectetur. Arcu tellus adipiscing rutrum sed eros venenatis et at. Sed fermentum ullamcorper urna habitant egestas. Netus turpis eu in parturient bibendum eget vitae. Tincidunt integer gravida dolor amet sed tellus amet ornare viverra. Nisl volutpat at a rhoncus urna et sed diam porta. Id pellentesque faucibus morbi.",
        ["assets/svgs/library.svg.vec", "assets/images/library.jpg"],
        4.0,
        const LatLng(7.305990571050196, 5.1397887288105),
      ),
      Location(
        "FUTA Library",
        "",
        "Lorem ipsum dolor sit amet consectetur. Arcu tellus adipiscing rutrum sed eros venenatis et at. Sed fermentum ullamcorper urna habitant egestas. Netus turpis eu in parturient bibendum eget vitae. Tincidunt integer gravida dolor amet sed tellus amet ornare viverra. Nisl volutpat at a rhoncus urna et sed diam porta. Id pellentesque faucibus morbi.",
        ["assets/svgs/library.svg.vec", "assets/images/library.jpg"],
        4.1,
        const LatLng(7.305990571050196, 5.1397887288105),
      ),
    ];

    return Scaffold(
      backgroundColor: futa_map_colors.Colors.surface,
      body: SafeArea(
        child: SizedBox(
          width: _deviceWidth,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: futa_map_colors.Colors.primary),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: futa_map_colors.Colors.primary,
                      size: 30,
                    ),
                    SizedBox(
                      width: _deviceWidth * .7,
                      child: TextFormField(
                        onChanged: (p0) => setState(() => searchText = p0),
                        cursorColor: const Color(0xFF3734A9),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        decoration: const InputDecoration(
                          fillColor: Color(0xFFF9FAFB),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.transparent,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.transparent,
                            ),
                          ),
                          hintText: "Search here",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  children: locations
                      .mapIndexed(
                        (i, e) => locationComponent(
                          location: e,
                          index: i,
                          onPress: (p0) => {
                            Navigator.pushNamed(
                              context,
                              PlaceDetailScreen.routeName,
                              arguments: e,
                            )
                          },
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
