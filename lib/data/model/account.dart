import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  String name;
  String uid;
  String? photoUrl;
  String email;
  List<String>? bookmarks;

  Account(
    this.name,
    this.uid,
    this.email, {
    this.photoUrl,
    this.bookmarks,
  });

  factory Account.fromMap(Map map) {
    Account item = Account(
      map['name'],
      map['uid'],
      map['email'],
      photoUrl: map['photoUrl'],
      bookmarks: map['bookmarks'],
    );
    return item;
  }

  factory Account.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    Account item = Account(
      data?['name'],
      data?['uid'],
      data?['email'],
      photoUrl: data?['photoUrl'],
      bookmarks:
          data?['bookmarks'] is Iterable ? List.from(data?['bookmarks']) : null,
    );
    return item;
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "uid": uid,
      "email": email,
      if (photoUrl != null) "photoUrl": photoUrl,
      if (bookmarks != null) "bookmarks": bookmarks,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'email': email,
      if (photoUrl != null) "photoUrl": photoUrl,
      if (bookmarks != null) "bookmarks": bookmarks,
    };
  }
}
