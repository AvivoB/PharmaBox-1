// ignore: file_names
part of 'specialisations_bloc.dart';

abstract class SpecialisationsState {
   List<Specialisation> _specialisations;
   SpecialisationsState( List<Specialisation> specialisations)
      : _specialisations = specialisations;
  List<Specialisation> get specialisations => _specialisations;
}

//empty state
class SpecialisationsInitial extends SpecialisationsState {
   SpecialisationsInitial(super.specialisations);
}

class SpecialisationsReady extends SpecialisationsState {
   SpecialisationsReady(super.specialisations);
}
