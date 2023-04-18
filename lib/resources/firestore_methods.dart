// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import 'package:hitch_handler/models/post.dart';
import 'package:hitch_handler/resources/storage_methods.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String uid,
    String name,
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
      final commentRef =
          _firestore.collection('posts').doc(postId).collection('comments');
      final issatisfiedRef =
          _firestore.collection('posts').doc(postId).collection('issatisfied');

      List<String> files = [];
      for (var i = 0; i < imgList.length; i++) {
        File file = imgList[i];
        String photoUrl =
            await StorageMethods().uploadImagetoStorage(postId, file);
        files.add(photoUrl);
      }

      Map<String, dynamic> comments = {
        "datePublished": DateTime.now(),
        "uid": '',
        "name": '<First Log>',
        "oldStatus": '',
        "newStatus": 'In Review',
        "message": 'This is the first log.',
      };
      commentRef.add(comments);

      Map<String, dynamic> issatisfied = {
        "datePublished": DateTime.now(),
        "uid": '****',
        "choice": 'no',
        "reason": 'first log',
      };
      issatisfiedRef.add(issatisfied);

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
        satisfied: null,
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
        await db.update({'upVoteCount': upVotes.length - 1});
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'upVotes': FieldValue.arrayUnion([uid]),
        });

        await db.update({'upVoteCount': upVotes.length + 1});
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

  Future<String> updateStatus(String postId, String uid, String toAdd,
      String newstatus, String name) async {
    final postRef =
        await FirebaseFirestore.instance.collection('posts').doc(postId).get();
    final data = postRef.data();

    Map<String, dynamic> comments = {
      "datePublished": DateTime.now(),
      "uid": data!['uid'],
      "name": name,
      "oldStatus": data['status'],
      "newStatus": newstatus,
      "message": toAdd,
    };

    try {
      var db1 = _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc()
          .set(comments);

      var db2 = _firestore.collection('posts').doc(postId);
      await db2.update({
        'status': newstatus,
      });
      await db2.update({
        'satisfied': null,
      });

      debugPrint("UpdateChangeSuccess");
      return "success";
    } catch (err) {
      debugPrint("$err");
      return "$err";
    }
  }

  Future<String> isSatisfiedUpdate(
      String postId, String choice, String reason) async {
    final postRef =
        await FirebaseFirestore.instance.collection('posts').doc(postId).get();
    final data = postRef.data();

    Map<String, dynamic> issatisfied = {
      "datePublished": DateTime.now(),
      "uid": data!['uid'],
      "choice": choice,
      "reason": reason,
    };

    try {
      var db1 = _firestore
          .collection('posts')
          .doc(postId)
          .collection('issatisfied')
          .doc()
          .set(issatisfied);

      var db2 = _firestore.collection('posts').doc(postId);
      await db2.update({
        'satisfied': choice,
      });

      debugPrint("isSatisfiedUpdateSuccess");
      return "success";
    } catch (err) {
      debugPrint("$err");
      return "$err";
    }
  }
}
