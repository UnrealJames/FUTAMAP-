import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:futamap/components/textfields.dart';
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

    var searchText = '';

    return Scaffold(
      backgroundColor: futa_map_colors.Colors.surface,
      body: SafeArea(
        child: SizedBox(
          width: _deviceWidth,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: futa_map_colors.Colors.primary),
                  borderRadius: BorderRadius.circular(50),
                ),
                width: _deviceWidth * .9,
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
            ],
          ),
        ),
      ),
    );
  }
}
