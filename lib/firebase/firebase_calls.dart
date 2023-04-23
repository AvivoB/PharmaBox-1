import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';

import '../model/models.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/user_models/pharmacie.dart';

class FirebaseCalls {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<Pharmacie?> getPharmacie(NonTitulaire membre) async {
    if (membre.poste == "Titulaire") {
      List<Pharmacie> result = await _firebaseFirestore
          .collection('pharmacie')
          .where('titulaires', arrayContains: '${membre.prenom} ${membre.nom}')
          .get()
          .then((value) {
        print("alo");
        print(value);
        return value.docs.map((e) => Pharmacie.fromJson(e.data())).toList();
      });
      print(result[0].nom);
      return result[0];
    }
    return null;
  }

  Future getLgos(String input) async {
    List<Lgo> groupements = [];
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
<<<<<<< HEAD
<<<<<<< HEAD
        groupements = [
          ...groupements,
          Lgo(nom: data["name"], niveau: 0, image: imageUrl)
        ];
=======
        groupements = [...groupements, Lgo(nom: data["name"], niveau: 0)];
>>>>>>> parent of a4a7365e (new requirements)
=======
        groupements = [...groupements, Lgo(nom: data["name"], niveau: 0,image:imageUrl)];
>>>>>>> parent of 000e9f71 (new changes)
      }
    }
    return groupements;
  }

  Future updateExpereinces(List<Experience> experiences) async {
    final currentUser = firebaseAuth.currentUser;
    await _firebaseFirestore.collection("users").doc(currentUser!.uid).set({
      "experiences": experiences.map((e) => e.toJson()).toList(),
    });
  }

  Future updateUniversites(List<Universite> experiences) async {
    final currentUser = firebaseAuth.currentUser;
    await _firebaseFirestore.collection("users").doc(currentUser!.uid).set({
      "universites": experiences.map((e) => e.toJson()).toList(),
    });
  }

  Future updateLangues(List<Langue> experiences) async {
    final currentUser = firebaseAuth.currentUser;
    await _firebaseFirestore.collection("users").doc(currentUser!.uid).set({
      "langues": experiences.map((e) => e.toJson()).toList(),
    });
  }

  Future updateCompetences(List<Competence> _competences) async {
    final currentUser = firebaseAuth.currentUser;
    await _firebaseFirestore.collection("users").doc(currentUser!.uid).set({
      "competences": {
        "test Covid": _competences[0].enabled,
        "test 2": _competences[1].enabled,
        "test 3": _competences[2].enabled,
        "test 4": _competences[3].enabled,
        "test 5": _competences[4].enabled,
      },
    });
  }

  Future updateLgo(List<Lgo> experiences) async {
    final currentUser = firebaseAuth.currentUser;
    await _firebaseFirestore.collection("users").doc(currentUser!.uid).set({
      "lgos": experiences.map((e) => e.toJson()).toList(),
    });
  }

  Future updateTitulaires(List<String> experiences, String nomPharmacie) async {
    final currentUser = firebaseAuth.currentUser;
    await _firebaseFirestore
        .collection("users")
        .doc(currentUser!.uid)
        .collection("pharmacies")
        .doc(nomPharmacie)
        .set({"titulaires": experiences});
    print("updated correctly");
  }
}
