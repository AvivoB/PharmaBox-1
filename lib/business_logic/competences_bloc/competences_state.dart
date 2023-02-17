part of 'competences_bloc.dart';

@immutable
abstract class CompetencesState {
  final List<Competence> _competences;
  const CompetencesState(final List<Competence> competences)
      : _competences = competences;
  List<Competence> get competences => _competences;
}

class CompetencesInitial extends CompetencesState {
  const CompetencesInitial(super.competences);
}
