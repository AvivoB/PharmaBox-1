part of 'competences_bloc.dart';

@immutable
abstract class CompetencesEvent {}

class AddRemoveCompetence extends CompetencesEvent {
  final Competence _competence;
  AddRemoveCompetence({
    required Competence competence,
  }) : _competence = competence;
}
class AddRemoveRemoteCompetence extends CompetencesEvent {
  final Competence _competence;
  AddRemoveRemoteCompetence({
    required Competence competence,
  }) : _competence = competence;
}

class InitialiseCompetence extends CompetencesEvent {
  final List<Competence> _competences;

  InitialiseCompetence({
    required List<Competence> competences,
  }) : _competences = competences;
}
class Init extends CompetencesEvent{}
