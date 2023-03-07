part of 'recherche_bloc.dart';

abstract class RechercheEvent {}

class CreateRecherche extends RechercheEvent {
  final Recherche recherche;

  CreateRecherche({required this.recherche});
}
class GetUserRecherches extends RechercheEvent{}
