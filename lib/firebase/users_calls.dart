import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';

class UserService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  Future creerNonTitulaire(NonTitulaire user) async {
    try {
      User? authUser = firebaseAuth.currentUser!;
      print(user.photoUrl);
      final storageRef = FirebaseStorage.instance.ref();
      final profileRef = storageRef.child("users/profile/${authUser.uid}");
      await profileRef.getDownloadURL().then((value) async {
        await profileRef.delete();
        await profileRef.putFile(File(user.photoUrl));
        await profileRef.getDownloadURL().then((value) async {
          user.photoUrl = value;
        });
      }).catchError((error) async {
        await profileRef.putFile(File(user.photoUrl));
        await profileRef.getDownloadURL().then((value) async {
          user.photoUrl = value;
        });
      });

      await _firebaseFirestore
          .collection("users")
          .doc(authUser.uid)
          .set(user.toJson());
      print("success");
      print("hello");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future getCurrentUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return await _firebaseFirestore
          .collection("users")
          .doc(currentUser.uid)
          .get();
    }
    return null;
  }
}
