import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmabox/model/specialisation.dart';
part 'specialisationss_event.dart';
part 'specialisationss_state.dart';

class SpecialisationsBloc
    extends Bloc<SpecialisationsEvent, SpecialisationsState> {
  List<Specialisation> _specialisations;
  SpecialisationsBloc({required List<Specialisation> specialisations})
      : _specialisations = specialisations,
        super(SpecialisationsInitial([])) {
    on<AddLocalSpecialisation>((event, emit) {
      _specialisations = [..._specialisations, event._specialisation];
      emit(SpecialisationsReady(specialisations));
    });
    on<RemoveLocalSpecialisation>((event, emit) {
      _specialisations.remove(event._specialisation);
      emit(SpecialisationsReady(specialisations));
    });
    on<AddRemoteSpecialisation>((event, emit) {
      _specialisations = [..._specialisations, event._specialisation];
      emit(SpecialisationsReady(specialisations));
    });
    on<RemoveRemoteSpecialisation>((event, emit) {
      _specialisations.remove(event._specialisation);
      emit(SpecialisationsReady(specialisations));
    });
    on<UpdateSpecialisation>((event, emit) {
      emit(SpecialisationsReady(specialisations));
    });
    on<InitialiseSpecialisation>((event, emit) {
      _specialisations.clear();
      emit(SpecialisationsReady(specialisations));
    });
  }
}
