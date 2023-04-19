import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmabox/firebase/reseau_membres_service.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';

part 'verifier_membre_event.dart';
part 'verifier_membre_state.dart';

class VerifierMembreBloc
    extends Bloc<VerifierMembreEvent, VerifierMembreState> {
  MembresReseauService membresReseauService = MembresReseauService();
  VerifierMembreBloc() : super(VerifierMembreInitial()) {
    on<VerifierMembre>((event, emit) async {
      final bool existe = await membresReseauService.checkMembre(event.membre);
      if (existe) {
        emit(MembreExiste());
      } else {
        emit(MembreAbsent());
      }
    });
  }
}
