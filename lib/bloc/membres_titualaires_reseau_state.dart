// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'membres_titualaires_reseau_bloc.dart';

abstract class MembresTitualairesReseauState {
  const MembresTitualairesReseauState();
}

class MembresTitualairesReseauInitial extends MembresTitualairesReseauState {}

class MembresTitulairesReady extends MembresTitualairesReseauState {
  final List<NonTitulaire> membresTitulaires;
  const MembresTitulairesReady({
    required this.membresTitulaires,
  });
}
