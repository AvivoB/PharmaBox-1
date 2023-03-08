import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../firebase/pharmacie_calls.dart';
import '../model/groupement.dart';

part 'lgosearch_event.dart';
part 'lgosearch_state.dart';

class LgosearchBloc extends Bloc<LgosearchEvent, LgosearchState> {
   PharmacieCalls pharmacieCalls = PharmacieCalls();
  LgosearchBloc() : super(LgosearchInitial()) {
    on<GetAllLgos>((event, emit) async {
      emit(LgosearchLoading());
      List<Groupement> groupements = await pharmacieCalls.getLgos(event.input);
      emit(LgosearchReady(groupements: groupements));
    });
  }
}
