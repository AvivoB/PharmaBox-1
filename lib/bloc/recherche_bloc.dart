import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmabox/firebase/recherche_service.dart';
import 'package:pharmabox/model/user_models/recherche.dart';

part 'recherche_event.dart';
part 'recherche_state.dart';

class RechercheBloc extends Bloc<RechercheEvent, RechercheState> {
    RechercheService offreService = RechercheService();
  RechercheBloc() : super(RechercheInitial()) {
    on<CreateRecherche>((event, emit) async {
      await offreService.createRech(event.recherche);
    });
    on<GetUserRecherches>((event, emit) async {
      List<Recherche> offres = await offreService.getUserRecherches();
      emit(RecherchesReady(recherches:offres));
    });
  }
}