part of 'experiences_bloc.dart';

@immutable
abstract class ExperiencesState {
   List<Experience> _experiences;
   ExperiencesState( List<Experience> experiences)
      : _experiences = experiences;
  List<Experience> get experiences => _experiences;
}

//empty state
class ExperiencesInitial extends ExperiencesState {
   ExperiencesInitial(super.experiences);
}

class ExperiencesReady extends ExperiencesState {
   ExperiencesReady(super.experiences);
}
