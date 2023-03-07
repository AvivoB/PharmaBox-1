part of 'membres_bloc.dart';

@immutable
abstract class MembresEvent {}

class GetMembres extends MembresEvent {
  final Offre offre;
  GetMembres({required this.offre});
}
class GetExplorerMembres extends MembresEvent {
  final places.LatLng input;
  GetExplorerMembres({required this.input});
}
class GetPharmaMembres extends MembresEvent {
  final places.LatLng input;
  GetPharmaMembres({required this.input});
}
class RechercheLibre extends MembresEvent {
  final String input;
  RechercheLibre({required this.input});
}

