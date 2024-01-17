import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:futamap/data/model/account.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User?> createAccount(
      String email, String password, String name) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      debugPrint("An error occurred: $e");
    }
    return null;
  }

  Future<User?> signin(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      debugPrint('An error occurred: $e');
    }
    return null;
  }

  Future<void> _updateUser(String name, String email, User user) async {
    try {
      var data = Account(name, user.uid, email);
      await user.updateDisplayName(name).then(
            (_) => {
              _db.collection("users").doc(user.uid).set(data.toMap()),
              // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //     content: Text('Account created successfully.'))),
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const LoginScreen(),
              //   ),
              // ),
            },
          );
    } catch (e) {
      debugPrint('An error occurred $e');
    }
  }
}
