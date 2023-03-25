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
  //final places.LatLng recherche;
  final List<OffreCard> offreCard;
  const GetExplorerOffres({required this.offreCard});
}
class GetMarkerOffres extends OffresEvent {
  final places.LatLng recherche;
  const GetMarkerOffres({required this.recherche});
}

class RechercheLibre extends OffresEvent {
  final String input;
  const RechercheLibre({required this.input});
}
