import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vector_graphics/vector_graphics.dart';
import '../../theme/colors.dart' as futa_map_colors;

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

    return Scaffold(
      backgroundColor: futa_map_colors.Colors.surface,
      body: SafeArea(
        child: SizedBox(
          width: _deviceWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
        ),
      ),
    );
  }
}
