import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pharmabox/model/models.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as places;
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import '../model/groupement.dart';
import '../model/user_models/pharmacie.dart';
import '../utils/map_utils.dart';

class PharmacieCalls {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future createPharmacie(Pharmacie pharmacie) async {
    final currentUser = firebaseAuth.currentUser;
    User? authUser = firebaseAuth.currentUser!;
    final storageRef = FirebaseStorage.instance.ref();
    print(pharmacie.images.length);
    for (int i = 0; i < pharmacie.images.length; i++) {
      final profileRef = storageRef
          .child("pharmacie/pharmacies/${pharmacie.nom + i.toString()}");
      File file = File(pharmacie.images[i]);
      if (file.existsSync()) {
        try {
          print(authUser.uid);
          await profileRef.getDownloadURL();
          await profileRef.delete();
          await profileRef.putFile(file);
          pharmacie.images[i] = await profileRef.getDownloadURL();
        } catch (e) {
          print(e.toString());

          if (e.toString() ==
              "[firebase_storage/object-not-found] No object exists at the desired reference.") {
            await profileRef.putFile(file);
            pharmacie.images[i] = await profileRef.getDownloadURL();
          }
        }
      }
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

  Future getGroupements(String input) async {
    List<Groupement> groupements = [];
    CollectionReference colRef = _firebaseFirestore.collection('groupements');
    QuerySnapshot querySnapshot = await colRef.get();
    final FirebaseStorage storage = FirebaseStorage.instance;

    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    for (var doc in documents) {
      dynamic data = doc.data()!;
      if (data["name"].toLowerCase().contains(input)) {
        final String imageName = data["image"];
        final Reference ref =
            storage.ref().child('groupements').child(imageName);
        String imageUrl = await ref.getDownloadURL();
        groupements = [
          ...groupements,
          Groupement(groupement: data["name"], image: imageUrl)
        ];
      }
    }
    return groupements;
  }

  Future getLgos(String input) async {
    List<Groupement> groupements = [];
    CollectionReference colRef = _firebaseFirestore.collection('lgo');
    QuerySnapshot querySnapshot = await colRef.get();
    final FirebaseStorage storage = FirebaseStorage.instance;

    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    for (var doc in documents) {
      dynamic data = doc.data()!;
      if (data["name"].toLowerCase().contains(input)) {
        final String imageName = data["image"];
        final Reference ref = storage.ref().child('lgo').child(imageName);
        String imageUrl = await ref.getDownloadURL();
        groupements = [
          ...groupements,
          Groupement(groupement: data["name"], image: imageUrl)
        ];
      }
    }
    return groupements;
  }
   Future getSpecialisations(String input) async {
    List<Groupement> groupements = [];
    CollectionReference colRef = _firebaseFirestore.collection('specialisation');
    QuerySnapshot querySnapshot = await colRef.get();
    final FirebaseStorage storage = FirebaseStorage.instance;

    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    for (var doc in documents) {
      dynamic data = doc.data()!;
      if (data["name"].toLowerCase().contains(input)) {
        groupements = [
          ...groupements,
          Groupement(groupement: data["name"], image: "")
        ];
      }
    }
    return groupements;
  }

  Future getExplorerPharmacies(places.LatLng input) async {
    List<Pharmacie> membres = await _firebaseFirestore
        .collection('pharmacie')
        .get()
        .then((value) =>
            value.docs.map((e) => Pharmacie.fromJson(e.data())).toList());
    List<Pharmacie> results = [];
    for (Pharmacie membre in membres) {
      places.LatLng dest =
          await MapUtils.getLocationFromAddress(membre.localisation.ville);
      if (MapUtils.computeDistance(input, dest) < 1) {
        results.add(membre);
      }
    }
    print("pharmacies");
    print(results.length);
    return results;
  }

  Future getLibrePharmacies(String input) async {
    List<Pharmacie> recherches = await _firebaseFirestore
        .collection("pharmacie")
        .where('nom', isEqualTo: input)
        .get()
        .then((value) =>
            value.docs.map((e) => Pharmacie.fromJson(e.data())).toList());
    List<Pharmacie> recherches1 = await _firebaseFirestore
        .collection("pharmacie")
        .where('code-postal', isEqualTo: input)
        .get()
        .then((value) =>
            value.docs.map((e) => Pharmacie.fromJson(e.data())).toList());
    List<Pharmacie> recherches3 = await _firebaseFirestore
        .collection("pharmacie")
        .where('ville', isEqualTo: input)
        .get()
        .then((value) =>
            value.docs.map((e) => Pharmacie.fromJson(e.data())).toList());
    var newList = [...recherches, ...recherches1, ...recherches3];

    return newList;
  }
}
