import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmabox/model/user_models/recherche.dart';

part 'recherche_pharmajob_event.dart';
part 'recherche_pharmajob_state.dart';

class RecherchePharmajobBloc
    extends Bloc<RecherchePharmajobEvent, RecherchePharmajobState> {
  List<Recherche> recherches = [];
  RecherchePharmajobBloc() : super(RecherchePharmajobInitial()) {
    on<GetRecherches>((event, emit) {
      recherches.clear();
      recherches = [...recherches, ...event.recherches];
      emit(RecherchesJobReady(recherches: recherches));
    });
  }
}
