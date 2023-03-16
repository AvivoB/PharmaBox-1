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
      "https://www.labodata.com/media/category/img/origin/paraph.png";
  final PharmacieCalls pharmacieCalls = PharmacieCalls();
  PharmacieBloc() : super(PharmacieInitial()) {
    on<AddPharmacie>((event, emit) async {
      pharmacie = event.pharmacie;
      print(pharmacie!.groupementImage);
      print(pharmacie!.groupementName);
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
