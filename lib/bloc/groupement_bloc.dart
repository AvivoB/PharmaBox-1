import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmabox/firebase/pharmacie_calls.dart';

import '../model/groupement.dart';

part 'groupement_event.dart';
part 'groupement_state.dart';

class GroupementBloc extends Bloc<GroupementEvent, GroupementState> {
  PharmacieCalls pharmacieCalls = PharmacieCalls();
  GroupementBloc() : super(GroupementInitial()) {
    on<GetAllGroupements>((event, emit) async {
      emit(GroupementsLoading());
      List<Groupement> groupements = await pharmacieCalls.getGroupements(event.input);
      emit(GroupementsReady(groupements: groupements));
    });
  }
}
