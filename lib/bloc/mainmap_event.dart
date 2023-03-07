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
