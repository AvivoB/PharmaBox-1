// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pharmacierecherche_bloc.dart';

@immutable
abstract class PharmacierechercheEvent {}

class GetExplorerPharmacies extends PharmacierechercheEvent {
  final places.LatLng recherche;
  GetExplorerPharmacies({
    required this.recherche,
  });
}

class RechercheLibre extends PharmacierechercheEvent {
  final String input;
  RechercheLibre({required this.input});
}
