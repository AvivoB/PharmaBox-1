part of 'offres_bloc.dart';

abstract class OffresEvent extends Equatable {
  const OffresEvent();

  @override
  List<Object> get props => [];
}

class CreateOffre extends OffresEvent {
  Offre offre;
  CreateOffre({required this.offre});
}

class GetPharmacieOffres extends OffresEvent {}

class GetFilteredOffres extends OffresEvent {
  final Recherche recherche;
  const GetFilteredOffres({required this.recherche});
}
class GetExplorerOffres extends OffresEvent {
  final places.LatLng recherche;
  const GetExplorerOffres({required this.recherche});
}

class RechercheLibre extends OffresEvent {
  final String input;
  RechercheLibre({required this.input});
}
