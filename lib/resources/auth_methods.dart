// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Project imports:
import 'package:hitch_handler/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  //Sign up user
  Future<String> signUpUser({
    required String userType,
    required String name,
    required String email,
    required String mobno,
    required String rollno,
    required String password,
    required String dob,
    required String domain,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          rollno.isNotEmpty ||
          dob.isNotEmpty ||
          mobno.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        debugPrint(cred.user!.uid);

        //add user to database
        model.User user = model.User(
          userType: userType,
          name: name,
          email: email,
          mobno: mobno,
          rollno: rollno,
          uid: cred.user!.uid,
          dob: dob,
          domain: domain,
          bookmarks: [],
        );
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      res = err.message!;
    }
    return res;
  }

  //Login user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        debugPrint(cred.user!.uid);

        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      res = err.message!;
      debugPrint(res);
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    debugPrint("Signed out!");
  }

  Future<void> passReset(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
