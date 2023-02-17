import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../firebase/firebase_calls.dart';
import '../../model/models.dart';

part 'langues_event.dart';
part 'langues_state.dart';

class LanguesBloc extends Bloc<LanguesEvent, LanguesState> {
  List<Langue> _langues;
  LanguesBloc({required List<Langue> langues})
      : _langues = langues,
        super(LanguesInitial([])) {
    on<AddLocalLangue>((event, emit) {
      _langues = [..._langues, event._langue];
      emit(LanguesReady(_langues));
    });
    on<InitialiseLangue>((event, emit) {
      _langues = event._langues;
      emit(LanguesReady(_langues));
    });
    on<RemoveLocalLangue>((event, emit) {
      _langues.remove(event._langue);
      emit(LanguesReady(langues));
    });
    on<AddRemoteLangue>((event, emit) async {
      _langues = [..._langues, event._langue];
      emit(LanguesReady(_langues));
      FirebaseCalls firebaseCalls = FirebaseCalls();
      await firebaseCalls.updateLangues(_langues);
    });
    on<RemoveRemoteLangue>((event, emit) async {
      _langues.remove(event._langue);
      emit(LanguesReady(_langues));
      FirebaseCalls firebaseCalls = FirebaseCalls();
      await firebaseCalls.updateLangues(_langues);
    });
    on<UpdateLangue>((event, emit) async {
      FirebaseCalls firebaseCalls = FirebaseCalls();
      await firebaseCalls.updateLangues(_langues);
      emit(LanguesReady(_langues));
    });
    on<Init>((event, emit) async {
      _langues.clear();
      emit(LanguesInitial(_langues));
    });
  }
}
