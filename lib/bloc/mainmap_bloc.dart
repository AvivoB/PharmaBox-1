import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:meta/meta.dart';
import 'package:pharmabox/bloc/membres_bloc.dart';
import 'package:pharmabox/bloc/offres_bloc.dart';
import 'package:pharmabox/bloc/pharmacierecherche_bloc.dart';
import 'package:pharmabox/bloc/recherche_pharmajob_bloc.dart';
import 'package:pharmabox/firebase/main_map_service.dart';
import 'package:pharmabox/firebase/membres_service.dart';
import 'package:pharmabox/firebase/offres_service.dart';
import 'package:pharmabox/firebase/pharmacie_calls.dart';
import 'package:pharmabox/firebase/recherche_service.dart';
import 'package:pharmabox/model/user_models/marker_model.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';
import 'package:pharmabox/model/user_models/offre_card.dart';
import 'package:pharmabox/model/user_models/pharmacie.dart';
import 'package:pharmabox/model/user_models/recherche.dart';

import '../utils/map_utils.dart';

part 'mainmap_event.dart';
part 'mainmap_state.dart';

class MainmapBloc extends Bloc<MainmapEvent, MainmapState> {
  MainMapService mainMapService = MainMapService();
  MembresBloc membresBloc;
  OffresBloc offresBloc;
  PharmacierechercheBloc pharmacierechercheBloc;
  RecherchePharmajobBloc recherchePharmajobBloc;
  MainmapBloc(
      {required this.membresBloc,
      required this.offresBloc,
      required this.pharmacierechercheBloc,
      required this.recherchePharmajobBloc})
      : super(MainmapInitial(models: const [])) {
    on<GetMarkersOnAddress>((event, emit) async {
      emit(ResultsLoading(models: const []));
      emit(ResultsLoading(models: const []));
      MembresService membresService = MembresService();
      OffreService offreService = OffreService();
      PharmacieCalls pharmacieCalls = PharmacieCalls();
      List<NonTitulaire> membres =
          await membresService.getLocationMembres(event.address);
      List<Pharmacie> pharmacies =
          await pharmacieCalls.getLocationPharmacie(event.address);
      List<OffreCard> offresCard =
          await offreService.getLocationOffres(event.address);
      Map<MarkerModel, int> markers = {};
      for (NonTitulaire membre in membres) {
        LatLng? geo =
            await MapUtils.getLocationFromAddress(membre.localisation.ville);
        MarkerModel model = MarkerModel(lat: geo!.lat, lng: geo.lng, count: 0);
        if (markers.containsKey(model)) {
          markers[model] = markers[model]! + 1;
        } else {
          markers[model] = 1;
        }
      }
      for (Pharmacie membre in pharmacies) {
        LatLng? geo =
            await MapUtils.getLocationFromAddress(membre.localisation.ville);
        MarkerModel model = MarkerModel(lat: geo!.lat, lng: geo.lng, count: 0);
        if (markers.containsKey(model)) {
          markers[model] = markers[model]! + 1;
        } else {
          markers[model] = 1;
        }
      }
      for (OffreCard membre in offresCard) {
        LatLng? geo = await MapUtils.getLocationFromAddress(
            membre.pharmacie.localisation.ville);
        MarkerModel model = MarkerModel(lat: geo!.lat, lng: geo.lng, count: 0);
        if (markers.containsKey(model)) {
          markers[model] = markers[model]! + 1;
        } else {
          markers[model] = 1;
        }
      }
      List<MarkerModel> results = [];
      markers.forEach(
        (key, value) =>
            results.add(MarkerModel(lat: key.lat, lng: key.lng, count: value)),
      );
      membresBloc.add(GetExplorerMembres(membres: membres));
      offresBloc.add(GetExplorerOffres(offreCard: offresCard));
      pharmacierechercheBloc.add(GetExplorerPharmacies(pharmacies: pharmacies));
      emit(ResultsReady(models: results));
    });

    on<GetLibreResults>((event, emit) async {
      emit(ResultsLoading(models: const []));
      MembresService membresService = MembresService();
      OffreService offreService = OffreService();
      PharmacieCalls pharmacieCalls = PharmacieCalls();
      List<NonTitulaire> membres =
          await membresService.getLibresMembres(event.address);
      List<Pharmacie> pharmacies =
          await pharmacieCalls.getLibrePharmacies(event.address);

      List<OffreCard> offresCard =
          await offreService.getLibresOffres(event.address);

      Map<MarkerModel, int> markers = {};
      for (NonTitulaire membre in membres) {
        LatLng? geo =
            await MapUtils.getLocationFromAddress(membre.localisation.ville);
        MarkerModel model = MarkerModel(lat: geo!.lat, lng: geo.lng, count: 0);
        if (markers.containsKey(model)) {
          markers[model] = markers[model]! + 1;
        } else {
          markers[model] = 1;
        }
      }
      for (Pharmacie membre in pharmacies) {
        LatLng? geo =
            await MapUtils.getLocationFromAddress(membre.localisation.ville);
        if (geo != null) {
          MarkerModel model = MarkerModel(lat: geo.lat, lng: geo.lng, count: 0);
          if (markers.containsKey(model)) {
            markers[model] = markers[model]! + 1;
          } else {
            markers[model] = 1;
          }
        }
      }
      for (OffreCard membre in offresCard) {
        LatLng? geo = await MapUtils.getLocationFromAddress(
            membre.pharmacie.localisation.ville);
        MarkerModel model = MarkerModel(lat: geo!.lat, lng: geo.lng, count: 0);
        if (markers.containsKey(model)) {
          markers[model] = markers[model]! + 1;
        } else {
          markers[model] = 1;
        }
      }
      List<MarkerModel> results = [];
      markers.forEach(
        (key, value) =>
            results.add(MarkerModel(lat: key.lat, lng: key.lng, count: value)),
      );
      membresBloc.add(GetExplorerMembres(membres: membres));
      offresBloc.add(GetExplorerOffres(offreCard: offresCard));
      pharmacierechercheBloc.add(GetExplorerPharmacies(pharmacies: pharmacies));
      emit(ResultsReady(models: results));
    });
    on<GetLibreMembres>((event, emit) async {
      emit(ResultsLoading(models: const []));
      MembresService membresService = MembresService();
      List<NonTitulaire> membres =
          await membresService.getLibresMembres(event.address);

      Map<MarkerModel, int> markers = {};
      for (NonTitulaire membre in membres) {
        LatLng? geo =
            await MapUtils.getLocationFromAddress(membre.localisation.ville);
        MarkerModel model = MarkerModel(lat: geo!.lat, lng: geo.lng, count: 0);
        if (markers.containsKey(model)) {
          print("yes");
          markers[model] = markers[model]! + 1;
        } else {
          markers[model] = 1;
        }
      }

      List<MarkerModel> results = [];
      markers.forEach(
        (key, value) =>
            results.add(MarkerModel(lat: key.lat, lng: key.lng, count: value)),
      );
      membresBloc.add(GetExplorerMembres(membres: membres));
      emit(ResultsReady(models: results));
    });
    on<GetLibreOffres>((event, emit) async {
      emit(ResultsLoading(models: const []));
      OffreService offreService = OffreService();
      print("weeeee");
      List<OffreCard> offresCard =
          await offreService.getLibresOffres(event.address);

      Map<MarkerModel, int> markers = {};

      for (OffreCard membre in offresCard) {
        LatLng? geo = await MapUtils.getLocationFromAddress(
            membre.pharmacie.localisation.ville);
        MarkerModel model = MarkerModel(lat: geo!.lat, lng: geo.lng, count: 0);
        if (markers.containsKey(model)) {
          markers[model] = markers[model]! + 1;
        } else {
          markers[model] = 1;
        }
      }
      List<MarkerModel> results = [];
      markers.forEach(
        (key, value) =>
            results.add(MarkerModel(lat: key.lat, lng: key.lng, count: value)),
      );
      offresBloc.add(GetExplorerOffres(offreCard: offresCard));
      emit(ResultsReady(models: results));
    });

    on<GetLibreRecherches>((event, emit) async {
      emit(ResultsLoading(models: const []));
      print("secod call");
      RechercheService rechercheService = RechercheService();
      List<Recherche> membres =
          await rechercheService.getLibreRecherches(event.address);

      Map<MarkerModel, int> markers = {};
      for (Recherche membre in membres) {
        if (membre.localisation.isNotEmpty) {
          print(membre.localisation);
          LatLng? geo =
              await MapUtils.getLocationFromAddress(membre.localisation);
          MarkerModel model =
              MarkerModel(lat: geo!.lat, lng: geo.lng, count: 0);
          if (markers.containsKey(model)) {
            print("yes");
            markers[model] = markers[model]! + 1;
          } else {
            markers[model] = 1;
          }
        }
      }
      List<MarkerModel> results = [];
      markers.forEach(
        (key, value) =>
            results.add(MarkerModel(lat: key.lat, lng: key.lng, count: value)),
      );
      recherchePharmajobBloc.add(GetRecherches(recherches: membres));
      emit(ResultsReady(models: results));
    });

    on<GetMixedOffres>((event, emit) async {
      emit(ResultsLoading(models: const []));
      OffreService offreService = OffreService();
      List<OffreCard> offresCard =
          await offreService.getCustomOffres(event.recherche);

      Map<MarkerModel, int> markers = {};

      for (OffreCard membre in offresCard) {
        LatLng? geo = await MapUtils.getLocationFromAddress(
            membre.pharmacie.localisation.ville);
        MarkerModel model = MarkerModel(lat: geo!.lat, lng: geo.lng, count: 0);
        if (markers.containsKey(model)) {
          markers[model] = markers[model]! + 1;
        } else {
          markers[model] = 1;
        }
      }
      List<MarkerModel> results = [];
      markers.forEach(
        (key, value) =>
            results.add(MarkerModel(lat: key.lat, lng: key.lng, count: value)),
      );
      offresBloc.add(GetExplorerOffres(offreCard: offresCard));
      emit(ResultsReady(models: results));
    });
  }
}
