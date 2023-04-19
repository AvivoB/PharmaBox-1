import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmabox/firebase/notifications_service.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';
import 'package:pharmabox/model/user_models/pharmacie.dart';

class MembresReseauService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  NotificationsService notificationsService = NotificationsService();

  Future getMembres() async {
    return await _firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("membres")
        .where("poste", isNotEqualTo: "Pharmacien(ne) titulaire")
        .get()
        .then((value) =>
            value.docs.map((e) => NonTitulaire.fromJson(e.data())).toList());
  }

  Future addMembre(NonTitulaire membre) async {
    await _firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("membres")
        .doc(membre.id)
        .set(membre.toJson());
    if (membre.poste == "Pharmacien(ne) titulaire") {
      await notificationsService.sendChatMessage(
          "Voulez-vous rejoindre le réseau de la pharmacie?", membre.token);
    }
  }

  Future<bool> checkMembre(NonTitulaire membre) async {
    DocumentSnapshot doc = await _firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("membres")
        .doc(membre.id)
        .get();
    return doc.exists;
  }

  Future removeMembre(NonTitulaire membre) async {
    await _firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("membres")
        .where("id", isEqualTo: membre.id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }

  Future getMembresTitulaire() async {
    return await _firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("membres")
        .where("poste", isEqualTo: "Pharmacien(ne) titulaire")
        .get()
        .then((value) =>
            value.docs.map((e) => NonTitulaire.fromJson(e.data())).toList());
  }

  Future addPharmacie(Pharmacie pharmacie) async {
    List<NonTitulaire> titulaires = [];
    Iterator<String> iterator = pharmacie.titulaires.iterator;
    while (iterator.moveNext()) {
      String email = iterator.current;
      List<NonTitulaire> nonTitulaires = await _firebaseFirestore
          .collection("users")
          .where("email", isEqualTo: email)
          .get()
          .then((value) =>
              value.docs.map((e) => NonTitulaire.fromJson(e.data())).toList());
      titulaires = [...titulaires, ...nonTitulaires];
    }
    titulaires.forEach((element) async {
      addMembre(element);
    });
    await _firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("pharmacies")
        .add(pharmacie.toJson());
  }

  Future removePharmacie(Pharmacie pharmacie) async {
    await _firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .collection("pharmacies")
        .where("pharmacyId", isEqualTo: pharmacie.id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }
}
