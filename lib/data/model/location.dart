import 'package:cloud_firestore/cloud_firestore.dart';

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
      map['latlng'],
      isFavorite: map['isFavorite'],
    );
    return item;
  }

  // factory Location.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();
  //   Location item = Location(
  //     data?['name'],
  //     data?['uid'],
  //     data?['email'],
  //     photoUrl: data?['photoUrl'],
  //     bookmarks:
  //         data?['bookmarks'] is Iterable ? List.from(data?['bookmarks']) : null,
  //   );
  //   return item;
  // }

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

  @override
  String toString() =>
      'Location(name: $name, id: $id, description: $description, images: $images, rating: $rating, latlng: $latlng, isFavorite: $isFavorite)';
}
