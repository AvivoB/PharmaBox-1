part of 'membres_gestion_bloc.dart';

abstract class MembresGestionState extends Equatable {
  const MembresGestionState();

  @override
  List<Object> get props => [];
}

class MembresGestionInitial extends MembresGestionState {}

class MembreDeletedSuccess extends MembresGestionState {}

class MembreDeletedFail extends MembresGestionState {}

class MembreAddSuccess extends MembresGestionState {}

class MembreAddFailed extends MembresGestionState {}
