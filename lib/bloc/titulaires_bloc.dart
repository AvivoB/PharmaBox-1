import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../firebase/firebase_calls.dart';

part 'titulaires_event.dart';
part 'titulaires_state.dart';

class TitulaireBloc extends Bloc<TitulairesEvent, TitulairesState> {
  List<String> titulaires;
  TitulaireBloc({required this.titulaires})
      :
        super(const TitulairesInitial([])) {
    on<AddLocalTitulaire>((event, emit) {
      titulaires = [...titulaires, event._titulaires];
      emit(TitulairesReady(titulaires));
    });
    on<InitialiseTitulaire>((event, emit) {
      print("called");
      titulaires = event.titulaires;
      emit(TitulairesReady(titulaires));
    });
    on<RemoveLocalTitulaire>((event, emit) {
      titulaires.remove(event._titulaires);
      emit(TitulairesReady(titulaires));
    });
    on<AddRemoteTitulaire>((event, emit) async {
      titulaires = [...titulaires, event._titulaires];
      emit(TitulairesReady(titulaires));
      FirebaseCalls firebaseCalls = FirebaseCalls();
      await firebaseCalls.updateTitulaires(titulaires, event.nomPharmacie);
    });
    on<RemoveRemoteTitulaire>((event, emit) async {
      titulaires.remove(event._titulaires);
      emit(TitulairesReady(titulaires));
      FirebaseCalls firebaseCalls = FirebaseCalls();
      await firebaseCalls.updateTitulaires(titulaires, event.nomPharmacie);
    });
    on<UpdateTitulaire>((event, emit) async {
      FirebaseCalls firebaseCalls = FirebaseCalls();
      await firebaseCalls.updateTitulaires(titulaires, event.nomPharmacie);
      emit(TitulairesReady(titulaires));
    });
    on<InitTitu>((event, emit) async {
      print("called");
      titulaires.clear();
      emit(const TitulairesInitial([]));
    });
  }
}
