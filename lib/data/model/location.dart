import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  String name;
  String id;
  String description;
  List<dynamic>? images;
  String? rating;
  GeoPoint? latlng;
  bool? isFavorite = false;

  Location(
    this.name,
    this.id,
    this.description,
    this.images,
    this.rating,
    this.latlng, {
    this.isFavorite = false,
  });

  factory Location.fromMap(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final map = documentSnapshot.data()!;
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
      'latlng': latlng,
      'isFavorite': isFavorite
    };
  }
}
