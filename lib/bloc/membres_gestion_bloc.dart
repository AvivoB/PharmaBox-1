import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pharmabox/bloc/membres_bloc.dart';
import 'package:pharmabox/bloc/membres_titualaires_reseau_bloc.dart';
import 'package:pharmabox/firebase/reseau_membres_service.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';

part 'membres_gestion_event.dart';
part 'membres_gestion_state.dart';

class MembresGestionBloc
    extends Bloc<MembresGestionEvent, MembresGestionState> {
  MembresReseauService membresReseauService = MembresReseauService();
  MembresBloc membresBloc;
  MembresTitualairesReseauBloc membresTitualairesReseauBloc;
  MembresGestionBloc(
      {required this.membresBloc, required this.membresTitualairesReseauBloc})
      : super(MembresGestionInitial()) {
    on<AddMembre>((event, emit) async {
      try {
        await membresReseauService.addMembre(event.membre);
        emit(MembreAddSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(MembreAddFailed());
      }
    });
    on<DeleteMembre>((event, emit) async {
      try {
        await membresReseauService.removeMembre(event.membre);
        membresTitualairesReseauBloc.add(GetMembresTitulaires());
        membresBloc.add(GetReseauMembres());
        emit(MembreDeletedSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(MembreDeletedFail());
      }
    });
  }
}
