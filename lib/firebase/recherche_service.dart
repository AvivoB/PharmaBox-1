import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_models/recherche.dart';

class RechercheService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future createRech(Recherche recherche) async {
    final currentUser = firebaseAuth.currentUser;
    recherche.userId = currentUser!.uid;
    final Map<String, dynamic> mappedOffre = recherche.toMap();
    await _firebaseFirestore.collection("recherches").add(mappedOffre);
    await _firebaseFirestore
        .collection("recherches")
        .doc(currentUser.uid)
        .collection("recherches")
        .doc(recherche.nom)
        .set(mappedOffre)
        .catchError((error) {
      print(error.toString());
    });
  }

  Future getUserRecherches() async {
    final currentUser = firebaseAuth.currentUser;
    return await _firebaseFirestore
        .collection("recherches")
        .doc(currentUser!.uid)
        .collection("recherches")
        .get()
        .then((value) =>
            value.docs.map((e) => Recherche.fromMap(e.data())).toList());
  }

  Future getLibreRecherches(String input) async {
    List<Recherche> recherches = await _firebaseFirestore
        .collection("recherches")
        .where('nom', isGreaterThanOrEqualTo: input)
        .where('nom', isLessThanOrEqualTo: input + '\uf8ff')
        .get()
        .then((value) =>
            value.docs.map((e) => Recherche.fromMap(e.data())).toList());
    List<Recherche> recherches1 = await _firebaseFirestore
        .collection("recherches")
        .where('prenom', isGreaterThanOrEqualTo: input)
        .where('prenom', isLessThanOrEqualTo: input + '\uf8ff')
        .get()
        .then((value) =>
            value.docs.map((e) => Recherche.fromMap(e.data())).toList());
    List<Recherche> recherches2 = await _firebaseFirestore
        .collection("recherches")
        .where('poste', isGreaterThanOrEqualTo: input)
        .where('poste', isLessThanOrEqualTo: input + '\uf8ff')
        .get()
        .then((value) =>
            value.docs.map((e) => Recherche.fromMap(e.data())).toList());
    List<Recherche> recherches3 = await _firebaseFirestore
        .collection("recherches")
        .where('localisation', isEqualTo: input)
        .get()
        .then((value) =>
            value.docs.map((e) => Recherche.fromMap(e.data())).toList());
    var newList = [
      ...recherches,
      ...recherches2,
      ...recherches1,
      ...recherches3
    ];

    return newList;
  }
}
