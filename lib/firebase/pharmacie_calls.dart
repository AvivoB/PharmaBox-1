import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pharmabox/model/models.dart';

import '../model/groupement.dart';
import '../model/user_models/pharmacie.dart';

class PharmacieCalls {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future createPharmacie(Pharmacie pharmacie) async {
    final currentUser = firebaseAuth.currentUser;
    User? authUser = firebaseAuth.currentUser!;
    final storageRef = FirebaseStorage.instance.ref();
    print(pharmacie.images.length);
    for (int i = 0; i < pharmacie.images.length; i++) {
      final profileRef =
          storageRef.child("users/pharmacies/${pharmacie.nom + i.toString()}");
      await profileRef
          .getDownloadURL()
          .then((value) {})
          .catchError((err) async {
        await profileRef.putFile(File(pharmacie.images[i]));
        await profileRef.getDownloadURL().then((value) {
          pharmacie.images[i] = value;
        });
      });
    }

    await _firebaseFirestore
        .collection("pharmacie")
        .doc(currentUser!.uid)
        .set(pharmacie.toJson());
  }

  Future getPharmacie() async {
    final currentUser = firebaseAuth.currentUser;
    Pharmacie pharmacie;
    pharmacie = await _firebaseFirestore
        .collection("pharmacie")
        .doc(currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) =>
            Pharmacie.fromJson(documentSnapshot.data()));
    return pharmacie;
  }

  Future getGroupements() async {
    List<Groupement> groupements = [];
    CollectionReference colRef = _firebaseFirestore.collection('groupements');
    QuerySnapshot querySnapshot = await colRef.get();

    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    for (var doc in documents) {
      dynamic data = doc.data()!;
      final FirebaseStorage storage = FirebaseStorage.instance;
      final String imageName = data["image"];
      final Reference ref = storage.ref().child('groupements').child(imageName);
      String imageUrl = await ref.getDownloadURL();
      groupements = [
        ...groupements,
        Groupement(groupement: data["name"], image: imageUrl)
      ];
    }
    return groupements;
  }
}
