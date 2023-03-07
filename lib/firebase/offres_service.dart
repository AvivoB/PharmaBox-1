import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmabox/model/user_models/offre_card.dart';
import 'package:pharmabox/model/user_models/pharmacie.dart';
import 'package:pharmabox/model/user_models/recherche.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as places;
import '../model/user_models/offre.dart';
import '../utils/map_utils.dart';

class OffreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future createOffre(Offre offre) async {
    final currentUser = firebaseAuth.currentUser;
    offre.pharmacieId = currentUser!.uid;
    final mappedOffre = offre.toMap();
    await _firebaseFirestore.collection("offres").add(mappedOffre);
    await _firebaseFirestore
        .collection("pharmacie")
        .doc(currentUser.uid)
        .collection("offres")
        .add(mappedOffre);
  }

  Future getPharmacieOffres() async {
    final currentUser = firebaseAuth.currentUser;
    return await _firebaseFirestore
        .collection("pharmacie")
        .doc(currentUser!.uid)
        .collection("offres")
        .get()
        .then(
            (value) => value.docs.map((e) => Offre.fromMap(e.data())).toList());
  }

  Future getFilteredOffres(Recherche recherche) async {
    List<Offre> offres = await _firebaseFirestore
        .collection("offres")
        .where('localisation', isEqualTo: recherche.localisation)
        .get()
        .then(
            (value) => value.docs.map((e) => Offre.fromMap(e.data())).toList());
    List<OffreCard> results = [];
    for (Offre offerDoc in offres) {
      String pharmacyId = offerDoc.pharmacieId;
      Pharmacie pharmacie = await FirebaseFirestore.instance
          .collection('pharmacie')
          .doc(pharmacyId)
          .get()
          .then((value) => Pharmacie.fromJson(value.data()));
      OffreCard result =
          OffreCard(pharmacie: pharmacie, nomOffre: offerDoc.poste);
      results.add(result);
    }
    return results;
  }

  Future getExplorerOffres(places.LatLng localisation) async {
    List<Offre> membres = await _firebaseFirestore
        .collection('offres')
        .get()
        .then(
            (value) => value.docs.map((e) => Offre.fromMap(e.data())).toList());
    List<Offre> res = [];
    for (Offre membre in membres) {
      places.LatLng dest =
          await MapUtils.getLocationFromAddress(membre.localisation);
      if (MapUtils.computeDistance(localisation, dest) < 1) {
        res.add(membre);
      }
    }
    List<OffreCard> results = [];
    for (Offre offerDoc in res) {
      String pharmacyId = offerDoc.pharmacieId;
      Pharmacie pharmacie = await FirebaseFirestore.instance
          .collection('pharmacie')
          .doc(pharmacyId)
          .get()
          .then((value) => Pharmacie.fromJson(value.data()));
      OffreCard result =
          OffreCard(pharmacie: pharmacie, nomOffre: offerDoc.poste);
      results.add(result);
    }
    return results;
  }

  Future getLibresOffres(String input) async {
    List<Offre> offres = await _firebaseFirestore
        .collection("offres")
        .where('poste', isEqualTo: input)
        .get()
        .then(
            (value) => value.docs.map((e) => Offre.fromMap(e.data())).toList());
    List<OffreCard> results = [];
    for (Offre offerDoc in offres) {
      String pharmacyId = offerDoc.pharmacieId;
      Pharmacie pharmacie = await FirebaseFirestore.instance
          .collection('pharmacie')
          .doc(pharmacyId)
          .get()
          .then((value) => Pharmacie.fromJson(value.data()));
      OffreCard result =
          OffreCard(pharmacie: pharmacie, nomOffre: offerDoc.poste);
      results.add(result);
    }
    return results;
  }
}
