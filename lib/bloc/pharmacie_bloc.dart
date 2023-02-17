import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmabox/firebase/pharmacie_calls.dart';

import '../model/user_models/pharmacie.dart';

part 'pharmacie_event.dart';
part 'pharmacie_state.dart';

class PharmacieBloc extends Bloc<PharmacieEvent, PharmacieState> {
  List<Pharmacie>? pharmacies = [];
  String? imagePath;

  final PharmacieCalls pharmacieCalls = PharmacieCalls();
  PharmacieBloc() : super(PharmacieInitial()) {
    on<AddPharmacie>((event, emit) async {
      pharmacies = [...pharmacies!, event.pharmacie];
      await pharmacieCalls.createPharmacie(event.pharmacie);
      emit(PharmacieReady(pharmacies: pharmacies!));
      // TODO: implement event handler
    });
    on<GetAllPharmacies>((event, emit) async {
      try {
        List<Pharmacie?> pharmacies = await pharmacieCalls.getAllPharmacies();
        print(pharmacies.length);
        if (pharmacies.isEmpty) {
          throw Exception("empty pharmacies");
        }
        emit(PharmacieReady(pharmacies: pharmacies));
      } catch (e) {
        emit(PharmacieFailed());
      }
    });
  }
}
