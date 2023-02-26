import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userType;
  final String email;
  final String mobno;
  final String rollno;
  final String uid;
  final String dob;
  final String domain;
  final List bookmarks;

  const User({
    required this.userType,
    required this.email,
    required this.mobno,
    required this.rollno,
    required this.uid,
    required this.dob,
    required this.domain,
    required this.bookmarks,
  });

  Map<String, dynamic> toJson() => {
        "userType": userType,
        "email": email,
        "mobno": mobno,
        "rollno": rollno,
        "uid": uid,
        "dob": dob,
        "domain": domain,
        "bookmarks": bookmarks,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      userType: snapshot['userType'],
      email: snapshot['email'],
      rollno: snapshot['rollno'],
      mobno: snapshot['mobno'],
      uid: snapshot['uid'],
      dob: snapshot['dob'],
      domain: snapshot['domain'],
      bookmarks: snapshot['bookmarks'],
    );
  }
}
