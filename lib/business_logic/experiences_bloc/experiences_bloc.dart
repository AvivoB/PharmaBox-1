import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmabox/model/experience.dart';

import '../../firebase/firebase_calls.dart';

part 'experiences_event.dart';
part 'experiences_state.dart';

class ExperiencesBloc extends Bloc<ExperiencesEvent, ExperiencesState> {
  List<Experience> _experiences;
  ExperiencesBloc({required List<Experience> experiences})
      : _experiences = experiences,
        super(ExperiencesInitial([])) {
    on<AddLocalExperience>((event, emit) {
      _experiences = [..._experiences, event._experience];
      emit(ExperiencesReady(_experiences));
    });
    on<InitialiseExperience>((event, emit) {
      _experiences = event._experiences;
      emit(ExperiencesReady(_experiences));
    });
    on<RemoveLocalExperience>((event, emit) {
      _experiences.remove(event._experience);
      emit(ExperiencesReady(_experiences));
    });
    on<AddRemoteExperience>((event, emit) async {
      _experiences = [..._experiences, event._experience];
      emit(ExperiencesReady(_experiences));
      FirebaseCalls firebaseCalls = FirebaseCalls();
      await firebaseCalls.updateExpereinces(_experiences);
    });
    on<RemoveRemoteExperience>((event, emit) async {
      _experiences.remove(event._experience);
      emit(ExperiencesReady(_experiences));
      FirebaseCalls firebaseCalls = FirebaseCalls();
      await firebaseCalls.updateExpereinces(_experiences);
    });
    on<UpdateExperience>((event, emit) {
      emit(ExperiencesReady(_experiences));
    });
  }
}
