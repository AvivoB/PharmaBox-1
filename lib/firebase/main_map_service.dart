import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pharmabox/firebase/membres_service.dart';
import 'package:pharmabox/model/user_models/marker_model.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';
import 'package:pharmabox/utils/map_utils.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as place;
import 'dart:collection';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:google_maps_utils/google_maps_utils.dart';

class MainMapService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<List<MarkerModel>> getCloseLocationMmebres(String address) async {
    place.LatLng? location = await MapUtils.getLocationFromAddress(address);
    List<place.LatLng> membres = await Future.wait(await _firebaseFirestore
        .collection('users')
        .get()
        .then((value) async => value.docs.map((element) async {
              place.LatLng? result = await MapUtils.getLocationFromAddress(
                  element.data()['ville']);
              return place.LatLng(lat: result!.lat, lng: result.lng);
            }).toList()));
    ////membres
    membres = membres
        .where(
            (element) => (MapUtils.computeDistance(location!, element) < 50000))
        .toList();
    List<MarkerModel> resultList = [];
    [membres].expand((element) => element).forEach((model) {
      if (!resultList.any((existing) =>
          (existing.lat == model.lat) && (existing.lng == model.lng))) {
        // if model doesn't exist in the resultList, add it and set count to 1
        resultList.add(MarkerModel(lat: model.lat, lng: model.lng, count: 1));
      } else {
        // if model already exists in the resultList, increment count
        MarkerModel md = resultList.firstWhere(
            (element) => element.lat == model.lat && element.lng == model.lng);
        md.count = md.count + 1;
      }
    });
    return resultList;
  }

  Future<List<MarkerModel>> getCloseOffresResults(String address) async {
    place.LatLng? location = await MapUtils.getLocationFromAddress(address);
    List<place.LatLng> offres = await Future.wait(await _firebaseFirestore
        .collection('offres')
        .get()
        .then((value) async => value.docs.map((element) async {
              place.LatLng? result = await MapUtils.getLocationFromAddress(
                  element.data()['localisation']);
              return place.LatLng(lat: result!.lat, lng: result.lng);
            }).toList()));
    offres = offres
        .where(
            (element) => (MapUtils.computeDistance(location!, element) < 50000))
        .toList();
    List<MarkerModel> resultList = [];
    [offres].expand((element) => element).forEach((model) {
      if (!resultList.any((existing) =>
          (existing.lat == model.lat) && (existing.lng == model.lng))) {
        // if model doesn't exist in the resultList, add it and set count to 1
        resultList.add(MarkerModel(lat: model.lat, lng: model.lng, count: 1));
      } else {
        // if model already exists in the resultList, increment count
        MarkerModel md = resultList.firstWhere(
            (element) => element.lat == model.lat && element.lng == model.lng);
        md.count = md.count + 1;
      }
    });
    return resultList;
  }

  Future<List<MarkerModel>> getCloseLocationResults(String address) async {
    place.LatLng? location = await MapUtils.getLocationFromAddress(address);
    List<place.LatLng> membres = await Future.wait(await _firebaseFirestore
        .collection('users')
        .get()
        .then((value) async => value.docs.map((element) async {
              place.LatLng? result = await MapUtils.getLocationFromAddress(
                  element.data()['ville']);
              return place.LatLng(lat: result!.lat, lng: result.lng);
            }).toList()));
    ////membres
    membres = membres
        .where(
            (element) => (MapUtils.computeDistance(location!, element) < 10000))
        .toList();
    ////pharmacies
    List<place.LatLng> pharmacies = await Future.wait(await _firebaseFirestore
        .collection('pharmacie')
        .get()
        .then((value) async => value.docs.map((element) async {
              place.LatLng? result = await MapUtils.getLocationFromAddress(
                  element.data()['ville']);
              return place.LatLng(lat: result!.lat, lng: result.lng);
            }).toList()));
    pharmacies = pharmacies
        .where(
            (element) => (MapUtils.computeDistance(location!, element) < 10000))
        .toList();

    ///offres
    List<place.LatLng> offres = await Future.wait(await _firebaseFirestore
        .collection('offres')
        .get()
        .then((value) async => value.docs.map((element) async {
              place.LatLng? result = await MapUtils.getLocationFromAddress(
                  element.data()['localisation']);
              return place.LatLng(lat: result!.lat, lng: result.lng);
            }).toList()));
    offres = offres
        .where(
            (element) => (MapUtils.computeDistance(location!, element) < 10000))
        .toList();
    List<MarkerModel> resultList = [];
    [membres, pharmacies, offres].expand((element) => element).forEach((model) {
      if (!resultList.any((existing) =>
          (existing.lat == model.lat) && (existing.lng == model.lng))) {
        // if model doesn't exist in the resultList, add it and set count to 1
        resultList.add(MarkerModel(lat: model.lat, lng: model.lng, count: 1));
      } else {
        // if model already exists in the resultList, increment count
        MarkerModel md = resultList.firstWhere(
            (element) => element.lat == model.lat && element.lng == model.lng);
        md.count = md.count + 1;
      }
    });
    return resultList;
  }

  Future<List<MarkerModel>> getLibreResults(String input) async {
    MembresService membresService = MembresService();
    List<NonTitulaire> membres = await membresService.getLibresMembres(input);
    List<MarkerModel> resultList = [];
    return resultList;
  }
}
