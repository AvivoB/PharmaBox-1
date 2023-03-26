part of 'mainmap_bloc.dart';

@immutable
abstract class MainmapEvent {}

class GetMarkersOnAddress extends MainmapEvent {
  final String address;

  GetMarkersOnAddress({required this.address});
}

class GetMemberMarkersOnAddress extends MainmapEvent {
  final String address;

  GetMemberMarkersOnAddress({required this.address});
}

class GetOffresMarkersOnAddress extends MainmapEvent {
  final String address;

  GetOffresMarkersOnAddress({required this.address});
}
class GetLibreResults extends MainmapEvent {
  final String address;

  GetLibreResults({required this.address});
}
class GetLibreMembres extends MainmapEvent {
  final String address;

  GetLibreMembres({required this.address});
}
class GetLibreOffres extends MainmapEvent {
  final String address;

  GetLibreOffres({required this.address});
}
class GetMixedOffres extends MainmapEvent {
  final Recherche recherche;

  GetMixedOffres({required this.recherche});
}
