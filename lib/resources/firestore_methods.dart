// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import 'package:hitch_handler/resources/storage_methods.dart';
import '../models/post.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String uid,
    String title,
    String description,
    String? location,
    String domain,
    String? date,
    String? time,
    String isAnon,
    String isDept,
    List imgList,
  ) async {
    String res = "Some Error Occured";
    try {
      String postId = const Uuid().v1();

      List<String> files = [];
      for (var i = 0; i < imgList.length; i++) {
        File file = imgList[i];
        String photoUrl =
            await StorageMethods().uploadImagetoStorage(postId, file);
        files.add(photoUrl);
      }

      Post post = Post(
        postId: postId,
        uid: uid,
        title: title,
        description: description,
        location: location,
        domain: domain,
        date: date,
        datePublished: DateTime.now(),
        time: time,
        isAnon: isAnon,
        isDept: isDept,
        imgList: files,
        bookmarks: [],
        upVotes: [],
        upVoteCount: 0,
        status: "In Review",
        dateClosed: null,
        authUid: null,
        authRemark: null,
        rating: null,
      );

      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );

      res = "success";
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future<String> upVotePost(String postId, String uid, List upVotes) async {
    try {
      var db = _firestore.collection('posts').doc(postId);

      if (upVotes.contains(uid)) {
        await db.update({
          'upVotes': FieldValue.arrayRemove([uid]),
        });
        // FirebaseFirestore.instance
        //     .collection('posts')
        //     .doc(postId)
        //     .get()
        //     .then((DocumentSnapshot snap) async {
        //   if (snap.exists) {
        //     if (snap['upVoteCount'] > 0) {
        await db.update({'upVoteCount': FieldValue.increment(-1)});
        //     }
        //   }
        // });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'upVotes': FieldValue.arrayUnion([uid]),
        });

        await db.update({'upVoteCount': FieldValue.increment(1)});
      }
      debugPrint("UpVoteChangeSuccess");
      return "success";
    } catch (err) {
      debugPrint("$err");
      return "$err";
    }
  }

  Future<String> bookmarkPost(String postId, String uid, List bookmarks) async {
    try {
      var db = _firestore.collection('posts').doc(postId);
      if (bookmarks.contains(uid)) {
        await db.update({
          'bookmarks': FieldValue.arrayRemove([uid]),
        });
      } else {
        await db.update({
          'bookmarks': FieldValue.arrayUnion([uid]),
        });
      }
      debugPrint("BookmarkChangeSuccess");
      return "success";
    } catch (err) {
      debugPrint("$err");
      return "$err";
    }
  }
}
