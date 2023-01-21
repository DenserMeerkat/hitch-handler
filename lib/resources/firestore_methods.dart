import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hitch_handler/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/post.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String uid,
    String title,
    String description,
    String location,
    String domain,
    String date,
    String time,
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
        upVotes: [],
      );

      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );

      res = "PostUploadSuccess";
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future<String> upVotePost(String postId, String uid, List upVotes) async {
    try {
      if (upVotes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'upVotes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'upVotes': FieldValue.arrayUnion([uid]),
        });
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
      if (bookmarks.contains(postId)) {
        await _firestore.collection('users').doc(uid).update({
          'bookmarks': FieldValue.arrayRemove([postId]),
        });
      } else {
        await _firestore.collection('users').doc(uid).update({
          'bookmarks': FieldValue.arrayUnion([postId]),
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