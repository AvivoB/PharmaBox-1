import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmabox/firebase/membres_service.dart';
import 'package:pharmabox/model/user_models/offre.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as places;
import '../model/user_models/non_titulaire.dart';

part 'membres_event.dart';
part 'membres_state.dart';

class MembresBloc extends Bloc<MembresEvent, MembresState> {
  MembresService membresService = MembresService();
  MembresBloc() : super(MembresInitial()) {
    on<GetMembres>((event, emit) async {
      
      emit(MembresReady(membres: await membresService.getFilteredMembres(event.offre)));
    });
    on<GetExplorerMembres>((event, emit) async {
      emit(MembresReady(membres: await membresService.getExplorerMembres(event.input)));
    });
    on<GetPharmaMembres>((event, emit) async {
      emit(MembresReady(membres: await membresService.getExplorerMembres(event.input)));
    });
     on<RechercheLibre>((event, emit) async {
      List<NonTitulaire> membres = await membresService.getLibresMembres(event.input);
      emit(MembresReady(membres:membres ));
    });
  }
}
