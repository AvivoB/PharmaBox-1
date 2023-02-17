import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmabox/firebase/firebase_calls.dart';

import '../../model/models.dart';

part 'universites_event.dart';
part 'universites_state.dart';

class UniversitesBloc extends Bloc<UniversitesEvent, UniversitesState> {
  List<Universite> _universites;
  UniversitesBloc({required List<Universite> universities})
      : _universites = universities,
        super( UniversitesInitial([])) {
    on<AddLocalUniversite>((event, emit) {
            _universites = [..._universites, event._universite];

      emit(UniversitesReady(_universites));
    });
    on<IntiailiseUniversite>((event, emit) {
      _universites = event._universites;
      emit(UniversitesReady(_universites));
    });
    on<RemoveLocalUniversite>((event, emit) {
      _universites.remove(event._universite);
      emit(UniversitesReady(_universites));
    });
    on<AddRemoteUniversite>((event, emit) async {
                  _universites = [..._universites, event._universite];

      emit(UniversitesReady(_universites));
      FirebaseCalls firebaseCalls = FirebaseCalls();
      await firebaseCalls.updateUniversites(_universites);
    });
    on<RemoveRemoteUniversite>((event, emit) async {
      _universites.remove(event._universite);
      emit(UniversitesReady(_universites));
      FirebaseCalls firebaseCalls = FirebaseCalls();
      await firebaseCalls.updateUniversites(_universites);
    });
    on<UpdateUniversite>((event, emit) async {
      FirebaseCalls firebaseCalls = FirebaseCalls();
      await firebaseCalls.updateUniversites(_universites);
      emit(UniversitesReady(_universites));
    });
    on<Initi>((event, emit) async {
      _universites.clear();
      emit( UniversitesInitial([]));
    });
  }
}
