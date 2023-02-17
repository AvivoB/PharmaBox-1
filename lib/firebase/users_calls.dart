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

      if (user.photoUrl !=
          "https://firebasestorage.googleapis.com/v0/b/pharmabox-effd0.appspot.com/o/user.png?alt=media&token=fa1292f7-7679-4c3b-b6e5-7831a9ac4ca4") {
        final storageRef = FirebaseStorage.instance.ref();
        final profileRef = storageRef.child("users/profile/${authUser.uid}");
        await profileRef.getDownloadURL().then((value) async {
          user.photoUrl = value;
        }).catchError((error)async{
                    await profileRef.putFile(File(user.photoUrl));
        });
      }

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
