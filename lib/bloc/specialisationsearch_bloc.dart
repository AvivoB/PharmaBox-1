import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../firebase/pharmacie_calls.dart';
import '../model/groupement.dart';

part 'specialisationsearch_event.dart';
part 'specialisationsearch_state.dart';

class SpecialisationsearchBloc extends Bloc<SpecialisationsearchEvent, SpecialisationsearchState> {
   PharmacieCalls pharmacieCalls = PharmacieCalls();
  SpecialisationsearchBloc() : super(SpecialisationsearchInitial()) {
    on<GetAllSpecialisations>((event, emit) async {
      emit(SpecialisationsearchLoading());
      List<Groupement> groupements = await pharmacieCalls.getSpecialisations(event.input);
      emit(SpecialisationsearchReady(groupements: groupements));
    });
  }
}
