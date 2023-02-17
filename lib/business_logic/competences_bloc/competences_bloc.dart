import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmabox/business_logic/experiences_bloc/experiences_bloc.dart';

import '../../firebase/firebase_calls.dart';
import '../../model/competence.dart';

part 'competences_event.dart';
part 'competences_state.dart';

class CompetencesBloc extends Bloc<CompetencesEvent, CompetencesState> {
  List<Competence> _competences;
  CompetencesBloc({required List<Competence> competences})
      : _competences = competences,
        super(CompetencesInitial(competences)) {
    on<AddRemoveCompetence>((event, emit) {
      event._competence.enabled = !event._competence.enabled;
      emit(CompetencesInitial(_competences));
    });
    on<AddRemoveRemoteCompetence>((event, emit) async {
      event._competence.enabled = !event._competence.enabled;
      emit(CompetencesInitial(_competences));
      FirebaseCalls firebaseCalls = FirebaseCalls();
      await firebaseCalls.updateCompetences(_competences);
    });
    on<InitialiseCompetence>((event, emit) {
      _competences = event._competences;
      emit(CompetencesInitial(_competences));
    });
  }
}
