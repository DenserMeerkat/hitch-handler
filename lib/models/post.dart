import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String postId;
  final String uid;
  final String title;
  final String description;
  final String location;
  final String domain;
  final String date;
  final DateTime datePublished;
  final String time;
  final String isAnon;
  final String isDept;
  final List imgList;
  final List upVotes;

  const Post(
      {required this.postId,
      required this.uid,
      required this.title,
      required this.description,
      required this.location,
      required this.domain,
      required this.date,
      required this.datePublished,
      required this.time,
      required this.isAnon,
      required this.isDept,
      required this.imgList,
      required this.upVotes});

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "uid": uid,
        "title": title,
        "description": description,
        "location": location,
        "domain": domain,
        "date": date,
        "datePublished": datePublished,
        "time": time,
        "isAnon": isAnon,
        "isDept": isDept,
        "imgList": imgList,
        "upVotes": upVotes
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
        postId: snapshot["postId"],
        uid: snapshot["uid"],
        title: snapshot["title"],
        description: snapshot["description"],
        location: snapshot["location"],
        domain: snapshot["domain"],
        date: snapshot["date"],
        datePublished: snapshot["datePublished"],
        time: snapshot["time"],
        isAnon: snapshot["isAnon"],
        isDept: snapshot["isDept"],
        imgList: snapshot["imgList"],
        upVotes: snapshot["upVotes"]);
  }
}
