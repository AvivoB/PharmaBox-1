import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';

class UserService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  Future creerNonTitulaire(NonTitulaire user) async {
    User? authUser = firebaseAuth.currentUser!;
    print(user.photoUrl);
    if (user.photoUrl != '') {
      File file = File(user.photoUrl);
      if (file.existsSync()) {
        final storageRef = FirebaseStorage.instance.ref();
        final profileRef = storageRef
            .child('profile_picture')
            .child(authUser.uid)
            .child('${authUser.uid}.jpg');
        try {
          print(authUser.uid);
          await profileRef.getDownloadURL();
          await profileRef.delete();
          await profileRef.putFile(file);
          user.photoUrl = await profileRef.getDownloadURL();
        } catch (e) {
          print(e.toString());

          if (e.toString() ==
              "[firebase_storage/object-not-found] No object exists at the desired reference.") {
            await profileRef.putFile(file);
            user.photoUrl = await profileRef.getDownloadURL();
          }
        }
      }
    }

    await _firebaseFirestore
        .collection("users")
        .doc(authUser.uid)
        .set(user.toJson());
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
