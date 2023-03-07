import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmabox/firebase/pharmacie_calls.dart';
import 'package:pharmabox/model/user_models/pharmacie.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    as places;
part 'pharmacierecherche_event.dart';
part 'pharmacierecherche_state.dart';

class PharmacierechercheBloc
    extends Bloc<PharmacierechercheEvent, PharmacierechercheState> {
  PharmacieCalls pharmacieCalls = PharmacieCalls();
  PharmacierechercheBloc() : super(PharmacierechercheInitial()) {
    on<GetExplorerPharmacies>((event, emit) async {
      List<Pharmacie> pharmacies =
          await pharmacieCalls.getExplorerPharmacies(event.recherche);
      emit(ExplorerPharmacieReady(pharmacies: pharmacies));
    });
      on<RechercheLibre>((event, emit) async {
      List<Pharmacie> pharmacies = await pharmacieCalls.getLibrePharmacies(event.input);
      emit(ExplorerPharmacieReady(pharmacies: pharmacies));
    });
  }

}
