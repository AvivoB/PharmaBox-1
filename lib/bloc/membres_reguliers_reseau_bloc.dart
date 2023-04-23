import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'membres_reguliers_reseau_event.dart';
part 'membres_reguliers_reseau_state.dart';

class MembresReguliersReseauBloc extends Bloc<MembresReguliersReseauEvent, MembresReguliersReseauState> {
  MembresReguliersReseauBloc() : super(MembresReguliersReseauInitial()) {
    on<MembresReguliersReseauEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
