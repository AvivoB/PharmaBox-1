import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmabox/firebase/offres_service.dart';
import 'package:pharmabox/model/user_models/offre_card.dart';
import 'package:pharmabox/model/user_models/recherche.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as places;
import '../model/user_models/offre.dart';

part 'offres_event.dart';
part 'offres_state.dart';

class OffresBloc extends Bloc<OffresEvent, OffresState> {
  OffreService offreService = OffreService();
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
      List<OffreCard> offres =
          await offreService.getExplorerOffres(event.recherche);
      print(offres.length);
      emit(FilteredOffresReady(offres: offres));
    });

    on<RechercheLibre>((event, emit) async {
      List<OffreCard> offres = await offreService.getLibresOffres(event.input);
      emit(FilteredOffresReady(offres: offres));
    });
  }
}
