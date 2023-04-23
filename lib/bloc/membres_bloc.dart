import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:pharmabox/firebase/membres_service.dart';
import 'package:pharmabox/firebase/reseau_membres_service.dart';
import 'package:pharmabox/model/user_models/offre.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as places;
import '../model/user_models/non_titulaire.dart';
import '../utils/map_utils.dart';

part 'membres_event.dart';
part 'membres_state.dart';

class MembresBloc extends Bloc<MembresEvent, MembresState> {
  MembresService membresService = MembresService();
  MembresReseauService membresReseauService = MembresReseauService();
  List<NonTitulaire> membres = [];
  MembresBloc() : super(MembresInitial()) {
    on<GetMembres>((event, emit) async {
      emit(MembresReady(
          membres: await membresService.getFilteredMembres(event.offre)));
    });
    on<GetExplorerMembres>((event, emit) async {
      membres.clear();
      membres = [...membres, ...event.membres];
      emit(MembresReady(membres: membres));
    });
    on<GetPharmaMembres>((event, emit) async {
      emit(MembresReady(
          membres: await membresService.getExplorerMembres(event.input)));
    });
    on<RechercheLibre>((event, emit) async {
      List<NonTitulaire> membres =
          await membresService.getLibresMembres(event.input);
      emit(MembresReady(membres: membres));
    });
    on<GetMarkerMembres>((event, emit) async {
      List<NonTitulaire> results = [];
      for (NonTitulaire membre in membres) {
        places.LatLng? dest =
            await MapUtils.getLocationFromAddress(membre.localisation.ville);
        if (MapUtils.computeDistance(event.input, dest!) < 1) {
          results.add(membre);
        }
      }
      emit(MembresReady(membres: results));
    });
    on<GetReseauMembres>((event, state) async {
      try {
        List<NonTitulaire> membres = await membresReseauService.getMembres();
        emit(MembresProfileReady(membres: membres));
      } catch (e) {
        debugPrint(e.toString());
        emit(MembresInitial());
      }
    });
  }
}
