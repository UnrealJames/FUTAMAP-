class User {
  String name;
  String uid;
  String photoUrl;
  String email;

  User(
    this.name,
    this.uid,
    this.photoUrl,
    this.email,
  );

  factory User.fromMap(Map map) {
    User item = User(
      map['name'],
      map['uid'],
      map['photoUrl'],
      map['email'],
    );
    return item;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'photoUrl': photoUrl,
      'email': email,
    };
  }
}
