part of 'recherche_pharmajob_bloc.dart';

abstract class RecherchePharmajobEvent {}

class GetRecherches extends RecherchePharmajobEvent{
  final List<Recherche> recherches;
   GetRecherches({required this.recherches});
}
