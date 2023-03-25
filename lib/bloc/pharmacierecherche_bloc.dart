import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmabox/firebase/pharmacie_calls.dart';
import 'package:pharmabox/model/user_models/pharmacie.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as places;

import '../utils/map_utils.dart';
part 'pharmacierecherche_event.dart';
part 'pharmacierecherche_state.dart';

class PharmacierechercheBloc
    extends Bloc<PharmacierechercheEvent, PharmacierechercheState> {
  PharmacieCalls pharmacieCalls = PharmacieCalls();
  List<Pharmacie> pharmacies = [];
  PharmacierechercheBloc() : super(PharmacierechercheInitial()) {
    on<GetExplorerPharmacies>((event, emit) async {
      pharmacies = [...pharmacies, ...event.pharmacies];
      emit(ExplorerPharmacieReady(pharmacies: pharmacies));
    });
    on<RechercheLibre>((event, emit) async {
      List<Pharmacie> pharmacies =
          await pharmacieCalls.getLibrePharmacies(event.input);
      emit(ExplorerPharmacieReady(pharmacies: pharmacies));
    });
    on<GetMarkerPharmacies>((event, emit) async {
      List<Pharmacie> results = [];
    for (Pharmacie membre in pharmacies) {
      places.LatLng? dest =
          await MapUtils.getLocationFromAddress(membre.localisation.ville);
      if (MapUtils.computeDistance(event.recherche, dest!) < 1) {
        results.add(membre);
      }
    }
      emit(ExplorerPharmacieReady(pharmacies: results));
    });
  }
}
