import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmabox/firebase/pharmacie_calls.dart';

import '../model/user_models/pharmacie.dart';

part 'pharmacie_event.dart';
part 'pharmacie_state.dart';

class PharmacieBloc extends Bloc<PharmacieEvent, PharmacieState> {
  Pharmacie? pharmacie;
  List<String> images = [];
  String groupement = "Groupement";
  String groupementImage =
      "https://firebasestorage.googleapis.com/v0/b/pharmabox-effd0.appspot.com/o/groupements%2FAPP%20C%C3%B4te%20d'azur.jpg?alt=media&token=af8be44d-fb70-456a-9339-1202d9ff251b";
  final PharmacieCalls pharmacieCalls = PharmacieCalls();
  PharmacieBloc() : super(PharmacieInitial()) {
    on<AddPharmacie>((event, emit) async {
      pharmacie = event.pharmacie;
      await pharmacieCalls.createPharmacie(event.pharmacie);
      emit(PharmacieReady(pharmacie: pharmacie!));
    });
    on<GetPharmacie>((event, emit) async {
      try {
        pharmacie = await pharmacieCalls.getPharmacie();
        images = pharmacie!.images;
        print("${images.length} alo");
        print("origianl est:${pharmacie!.images.length}");
        emit(PharmacieReady(pharmacie: pharmacie!));
      } catch (e) {
        emit(PharmacieFailed());
      }
    });
  }
}
