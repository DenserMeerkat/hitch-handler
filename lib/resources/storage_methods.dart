import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImagetoStorage(
    String childName,
    File file,
  ) async {
    String id = const Uuid().v1();
    Reference ref = _storage.ref().child("posts").child(childName).child(id);

    UploadTask uploadTask = ref.putFile(file);

    TaskSnapshot snap = await uploadTask;
    String downloadurl = await snap.ref.getDownloadURL();

    return downloadurl;
  }
}
