import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pharmabox/firebase/reseau_membres_service.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';

part 'membres_titualaires_reseau_event.dart';
part 'membres_titualaires_reseau_state.dart';

class MembresTitualairesReseauBloc
    extends Bloc<MembresTitualairesReseauEvent, MembresTitualairesReseauState> {
  MembresReseauService membresReseauService = MembresReseauService();
  MembresTitualairesReseauBloc() : super(MembresTitualairesReseauInitial()) {
    on<GetMembresTitulaires>((event, emit) async {
      try {
        List<NonTitulaire> membresTitulaires =
            await membresReseauService.getMembresTitulaire();
        emit(MembresTitulairesReady(membresTitulaires: membresTitulaires));
      } catch (e) {
        debugPrint(e.toString());
        emit(MembresTitualairesReseauInitial());
      }
    });
  }
}
