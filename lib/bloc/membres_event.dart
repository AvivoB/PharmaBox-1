part of 'membres_bloc.dart';

@immutable
abstract class MembresEvent {}

class GetMembres extends MembresEvent {
  final Offre offre;
  GetMembres({required this.offre});
}

class GetExplorerMembres extends MembresEvent {
  // final places.LatLng input;
  final List<NonTitulaire> membres;
  GetExplorerMembres({required this.membres});
}

class GetPharmaMembres extends MembresEvent {
  final places.LatLng input;
  GetPharmaMembres({required this.input});
}

class GetMarkerMembres extends MembresEvent {
  final places.LatLng input;
  GetMarkerMembres({required this.input});
}

class GetReseauMembres extends MembresEvent {}

class RechercheLibre extends MembresEvent {
  final String input;
  RechercheLibre({required this.input});
}
