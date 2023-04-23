// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recherche_pharmajob_bloc.dart';

abstract class RecherchePharmajobState {}

class RecherchePharmajobInitial extends RecherchePharmajobState {}

class RecherchesJobReady extends RecherchePharmajobState {
  List<Recherche> recherches;
  RecherchesJobReady({
    required this.recherches,
  });
  
}
