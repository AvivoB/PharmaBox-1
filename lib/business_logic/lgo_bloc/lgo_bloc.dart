import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../firebase/firebase_calls.dart';
import '../../model/models.dart';

part 'lgo_event.dart';
part 'lgo_state.dart';

class LgoBloc extends Bloc<LgoEvent, LgoState> {
  List<Lgo> _lgos;
  LgoBloc({required List<Lgo> lgos})
      : _lgos = lgos,
        super(LgosInitial(lgos)) {
    on<AddLocalLgo>((event, emit) {
      _lgos = [..._lgos, event._lgo];
      emit(LgosReady(_lgos));
    });
    on<InitialiseLgo>((event, emit) {
      _lgos = event._lgos;
      emit(LgosReady(_lgos));
    });
    on<RemoveLocalLgo>((event, emit) {
      _lgos.remove(event._lgo);
      emit(LgosReady(_lgos));
    });
    on<AddRemoteLgo>((event, emit) async {
      _lgos = [..._lgos, event._lgo];
      emit(LgosReady(_lgos));
      FirebaseCalls firebaseCalls = FirebaseCalls();
      await firebaseCalls.updateLgo(_lgos);
    });
    on<RemoveRemoteLgo>((event, emit) async {
      _lgos.remove(event._lgo);
      emit(LgosReady(_lgos));
      FirebaseCalls firebaseCalls = FirebaseCalls();
      await firebaseCalls.updateLgo(_lgos);
    });
    on<UpdateLgo>((event, emit) async {
      FirebaseCalls firebaseCalls = FirebaseCalls();
      await firebaseCalls.updateLgo(_lgos);
      emit(LgosReady(_lgos));
    });
    on<Init>((event, emit) async {
      _lgos.clear();
      emit(LgosInitial(_lgos));
    });
  }
}
