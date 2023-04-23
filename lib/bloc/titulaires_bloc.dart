import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pharmabox/business_logic/users_bloc/users_bloc_bloc.dart';

import '../firebase/firebase_calls.dart';

part 'titulaires_event.dart';
part 'titulaires_state.dart';

class TitulaireBloc extends Bloc<TitulairesEvent, TitulairesState> {
  List<String> titulaires;
  UsersBlocBloc usersBlocBloc;
  TitulaireBloc({required this.titulaires, required this.usersBlocBloc})
      : super(TitulairesInitial(titulaires)) {
    on<AddLocalTitulaire>((event, emit) {
      titulaires = [...titulaires, event._titulaires];
      emit(TitulairesReady(titulaires));
    });
    on<InitialiseTitulaire>((event, emit) {
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
      titulaires.clear();
      titulaires = [
        ...titulaires,
        usersBlocBloc.currentUser!.prenom + ' ' + usersBlocBloc.currentUser!.nom
      ];
      debugPrint("is:" + titulaires[0]);
      emit(TitulairesInitial(titulaires));
    });
  }
}
