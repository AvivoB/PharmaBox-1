import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmabox/model/user_models/offre.dart';
import 'package:pharmabox/model/user_models/recherche.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as places;
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import '../model/user_models/non_titulaire.dart';
import '../utils/map_utils.dart';

class MembresService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future getFilteredMembres(Offre offre) async {
    List<Recherche> recherches = await _firebaseFirestore
        .collection("recherches")
        .where('localisation', isEqualTo: offre.localisation)
        .get()
        .then((value) =>
            value.docs.map((e) => Recherche.fromMap(e.data())).toList());
    List<NonTitulaire> results = [];
    for (Recherche rechercheDoc in recherches) {
      String userId = rechercheDoc.userId;
      NonTitulaire nonTitulaire = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get()
          .then((value) => NonTitulaire.fromJson(value.data()!));
      if (!results.contains(nonTitulaire)) {
        results.add(nonTitulaire);
      }
    }
    return results;
  }

  Future getExplorerMembres(places.LatLng input) async {
    List<NonTitulaire> membres = await _firebaseFirestore
        .collection('users')
        .get()
        .then((value) =>
            value.docs.map((e) => NonTitulaire.fromJson(e.data())).toList());
    List<NonTitulaire> results = [];
    print(input);
    for (NonTitulaire membre in membres) {
      places.LatLng dest =
          await MapUtils.getLocationFromAddress(membre.localisation.ville);
      if (MapUtils.computeDistance(input, dest) < 1) {
        results.add(membre);
      }
    }
    return results;
  }

  Future getLibresMembres(String input) async {
    List<NonTitulaire> recherches = await _firebaseFirestore
        .collection("users")
        .where('nom', isEqualTo: input)
        .get()
        .then((value) =>
            value.docs.map((e) => NonTitulaire.fromJson(e.data())).toList());
    List<NonTitulaire> recherches1 = await _firebaseFirestore
        .collection("users")
        .where('prenom', isEqualTo: input)
        .get()
        .then((value) =>
            value.docs.map((e) => NonTitulaire.fromJson(e.data())).toList());
    List<NonTitulaire> recherches2 = await _firebaseFirestore
        .collection("users")
        .where('poste', isEqualTo: input)
        .get()
        .then((value) =>
            value.docs.map((e) => NonTitulaire.fromJson(e.data())).toList());
    List<NonTitulaire> recherches3 = await _firebaseFirestore
        .collection("users")
        .where('ville', isEqualTo: input)
        .get()
        .then((value) =>
            value.docs.map((e) => NonTitulaire.fromJson(e.data())).toList());
    var newList = [...recherches, ...recherches2, ...recherches1,...recherches3];

    return newList;
  }
}
