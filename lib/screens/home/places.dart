// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:futamap/components/empty.dart';
import 'package:futamap/components/location.dart';
import 'package:futamap/data/model/location.dart';
import 'package:futamap/screens/home/place_detail.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../theme/colors.dart' as futa_map_colors;
import 'package:collection/collection.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  late double _deviceWidth;

  final _db = FirebaseFirestore.instance;
  final List<Location> _locations = [];
  final List<Location> _filteredLocations = [];
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getLocations();
    // FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: futa_map_colors.Colors.surface,
      body: SafeArea(
        child: SizedBox(
          width: _deviceWidth,
          child: (_locations.isEmpty)
              ? const Empty("No locations found",
                  "We couldn't find any locations. Please try again later.")
              : Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: futa_map_colors.Colors.primary),
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
                              controller: _searchController,
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
                              onChanged: (value) => {
                                setState(
                                  () => {
                                    _filteredLocations.clear(),
                                    _filteredLocations.addAll(
                                      _locations
                                          .where((element) => element.name
                                              .toLowerCase()
                                              .contains(value.toLowerCase()))
                                          .toList(),
                                    )
                                  },
                                )
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(children: [
                        StaggeredGrid.count(
                          crossAxisCount: 2,
                          children: _filteredLocations
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
                      ]),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> getLocations() async {
    debugPrint("GetLocations called");
    List<Location> locations = [];
    await _db.collection('places').get().then(
          (value) => {
            for (int i = 0; i < value.docs.length; i++)
              locations.add(Location.fromMap(value.docs[i]))
          },
        );
    setState(() {
      _locations.addAll(locations);
      if (_searchController.text.isEmpty) {
        _filteredLocations.addAll(locations);
      }
    });
  }
}
