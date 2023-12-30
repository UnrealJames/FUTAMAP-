import 'dart:ffi';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  String name;
  String id;
  String description;
  List<String> images;
  double rating;
  LatLng latLng;
  bool isFavorite = false;

  Location(
    this.name,
    this.id,
    this.description,
    this.images,
    this.rating,
    this.latLng, {
    this.isFavorite = false,
  });

  factory Location.fromMap(Map map) {
    Location item = Location(
      map['name'],
      map['id'],
      map['description'],
      map['images'],
      map['rating'],
      map['latLng'],
      isFavorite: map['isFavorite'],
    );
    return item;
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'description': description,
      'images': images,
      'rating': rating,
      'latlng': latLng,
      'isFavorite': isFavorite
    };
  }
}
