part of 'titulaires_bloc.dart';

abstract class TitulairesEvent extends Equatable {
  const TitulairesEvent();

  @override
  List<Object> get props => [];
}

class InitialiseTitulaire extends TitulairesEvent {
  final List<String> titulaires;

  InitialiseTitulaire({required this.titulaires});
}

class AddLocalTitulaire extends TitulairesEvent {
  final String _titulaires;
  AddLocalTitulaire({
    required String titulaire,
  }) : _titulaires = titulaire;
}

class RemoveLocalTitulaire extends TitulairesEvent {
  final String _titulaires;
  RemoveLocalTitulaire({
    required String titulaire,
  }) : _titulaires = titulaire;
}

class AddRemoteTitulaire extends TitulairesEvent {
  final String _titulaires;
  final String nomPharmacie;
  AddRemoteTitulaire({
    required String titulaire,
    required this.nomPharmacie,
  }) : _titulaires = titulaire;
}

class RemoveRemoteTitulaire extends TitulairesEvent {
  final String _titulaires;
  final String nomPharmacie;
  RemoveRemoteTitulaire({
    required String titulaire,
    required this.nomPharmacie,
  }) : _titulaires = titulaire;
}

class UpdateTitulaire extends TitulairesEvent {
  final String nomPharmacie;
  UpdateTitulaire({required this.nomPharmacie});
}

class InitTitu extends TitulairesEvent {}
