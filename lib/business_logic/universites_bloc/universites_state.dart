part of 'universites_bloc.dart';

@immutable
abstract class UniversitesState {
   List<Universite> _universities;
   UniversitesState( List<Universite> universities)
      : _universities = universities;
  List<Universite> get universities => _universities;
}

//empty state
class UniversitesInitial extends UniversitesState {
   UniversitesInitial(super.universities);
}

class UniversitesReady extends UniversitesState {
   UniversitesReady(super.universities);
}
