import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String mobno;
  final String rollno;
  final String uid;
  final String dob;
  final List posts;
  final List bookmarks;

  const User({
    required this.email,
    required this.mobno,
    required this.rollno,
    required this.uid,
    required this.dob,
    required this.posts,
    required this.bookmarks,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "mobno": mobno,
        "rollno": rollno,
        "uid": uid,
        "dob": dob,
        "posts": posts,
        "bookmarks": bookmarks,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      email: snapshot['email'],
      rollno: snapshot['rollno'],
      mobno: snapshot['mobno'],
      uid: snapshot['uid'],
      dob: snapshot['dob'],
      posts: snapshot['posts'],
      bookmarks: snapshot['bookmarks'],
    );
  }
}
