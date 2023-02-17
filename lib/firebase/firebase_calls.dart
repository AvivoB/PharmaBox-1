import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/models.dart';

class FirebaseCalls {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
