// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'membres_titualaires_reseau_bloc.dart';

abstract class MembresTitualairesReseauEvent extends Equatable {
  const MembresTitualairesReseauEvent();

  @override
  List<Object> get props => [];
}

class GetMembresTitulaires extends MembresTitualairesReseauEvent {}
