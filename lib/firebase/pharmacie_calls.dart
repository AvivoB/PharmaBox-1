import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmabox/model/models.dart';

import '../model/user_models/pharmacie.dart';

class PharmacieCalls {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future createPharmacie(Pharmacie pharmacie) async {
    final currentUser = firebaseAuth.currentUser;
    await _firebaseFirestore
        .collection("users")
        .doc(currentUser!.uid)
        .collection("pharmacies")
        .doc(pharmacie.nom)
        .set(pharmacie.toJson());
  }

  Future getAllPharmacies() async {
    final currentUser = firebaseAuth.currentUser;
    List<Pharmacie?> pharmacies = [];
    await _firebaseFirestore
        .collection("users")
        .doc(currentUser!.uid)
        .collection("pharmacies")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        pharmacies.add(Pharmacie.fromJson(doc.data()));
      });
    });
    return pharmacies;
  }
}
