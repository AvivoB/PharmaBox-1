part of 'titulaires_bloc.dart';

abstract class TitulairesState{
  final List<String> _titulaires;
  const TitulairesState(final List<String> titulaires)
      : _titulaires = titulaires;
  List<String> get titulaires => _titulaires;
}

//empty state
class TitulairesInitial extends TitulairesState {
  const TitulairesInitial(super.titulaires);
}

class TitulairesReady extends TitulairesState {
  const TitulairesReady(super.titulaires);
}