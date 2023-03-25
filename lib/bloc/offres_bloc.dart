import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmabox/bloc/mainmap_bloc.dart';
import 'package:pharmabox/firebase/offres_service.dart';
import 'package:pharmabox/model/user_models/offre_card.dart';
import 'package:pharmabox/model/user_models/recherche.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as places;
import '../model/user_models/offre.dart';
import '../utils/map_utils.dart';

part 'offres_event.dart';
part 'offres_state.dart';

class OffresBloc extends Bloc<OffresEvent, OffresState> {
  OffreService offreService = OffreService();
  List<OffreCard> offres = [];
  OffresBloc() : super(OffresInitial()) {
    on<CreateOffre>((event, emit) async {
      await offreService.createOffre(event.offre);
    });
    on<GetPharmacieOffres>((event, emit) async {
      List<Offre> offres = await offreService.getPharmacieOffres();
      emit(OffresReady(offres: offres));
    });
    on<GetFilteredOffres>((event, emit) async {
      List<OffreCard> offres =
          await offreService.getFilteredOffres(event.recherche);
      emit(FilteredOffresReady(offres: offres));
    });
    on<GetExplorerOffres>((event, emit) async {
      offres.clear();
      offres = [...offres, ...event.offreCard];
      emit(FilteredOffresReady(offres: offres));
    });
    on<GetMarkerOffres>((event, emit) async {
      List<OffreCard> results = [];
      for (OffreCard membre in offres) {
        places.LatLng? dest = await MapUtils.getLocationFromAddress(
            membre.pharmacie.localisation.ville);
        if (MapUtils.computeDistance(event.recherche, dest!) < 1) {
          results.add(membre);
        }
      }
      emit(FilteredOffresReady(offres: results));
    });

    on<RechercheLibre>((event, emit) async {
      List<OffreCard> offres = await offreService.getLibresOffres(event.input);

      emit(FilteredOffresReady(offres: offres));
    });
  }
}
