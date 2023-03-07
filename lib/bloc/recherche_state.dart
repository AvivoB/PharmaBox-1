part of 'recherche_bloc.dart';


abstract class RechercheState {}

class RechercheInitial extends RechercheState {}

class AddRechercheFailed extends RechercheState {}

class RechercheSuccess extends RechercheState {}

class RecherchesReady extends RechercheState {
  final List<Recherche> recherches;
  RecherchesReady({required this.recherches});
}
