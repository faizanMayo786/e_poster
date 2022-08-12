import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../model/blog_model.dart';

class PostService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  uploadPost(
    String uid,
    String title,
    String description,
    String username,
    Uint8List file,
  ) async {
    String res = 'Something went wrong';
    try {
      String photoUrl = await uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      Blog blog = Blog(
        title: title,
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now().toString(),
        postUrl: photoUrl,
      );
      _firestore.collection('posts').doc(postId).set(blog.toMap());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  uploadImageToStorage(String childName, Uint8List file, bool isPost) async {
    Reference reference =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      reference = reference.child(id);
    }
    UploadTask uploadTask = reference.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
