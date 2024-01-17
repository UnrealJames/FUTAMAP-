class Account {
  String name;
  String uid;
  String? photoUrl;
  String email;

  Account(
    this.name,
    this.uid,
    this.email, {
    this.photoUrl,
  });

  factory Account.fromMap(Map map) {
    Account item = Account(
      map['name'],
      map['uid'],
      map['email'],
      photoUrl: map['photoUrl'],
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
