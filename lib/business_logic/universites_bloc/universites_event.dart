// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'universites_bloc.dart';

@immutable
abstract class UniversitesEvent {}

class AddLocalUniversite extends UniversitesEvent {
   Universite _universite;
  AddLocalUniversite({
    required Universite universite,
  }) : _universite = universite;
}
class IntiailiseUniversite extends UniversitesEvent {
   List<Universite> _universites;
  IntiailiseUniversite({
    required List<Universite> universites,
  }) : _universites = universites;
}

class RemoveLocalUniversite extends UniversitesEvent {
   Universite _universite;
  RemoveLocalUniversite({
    required Universite universite,
  }) : _universite = universite;
}

class AddRemoteUniversite extends UniversitesEvent {
   Universite _universite;
  AddRemoteUniversite({
    required Universite universite,
  }) : _universite = universite;
}

class RemoveRemoteUniversite extends UniversitesEvent {
   Universite _universite;
  RemoveRemoteUniversite({
    required Universite universite,
  }) : _universite = universite;
}

class UpdateUniversite extends UniversitesEvent {
}
class Initi extends UniversitesEvent {
}
