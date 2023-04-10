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
  String lgo = "";
  String lgoImage = "https://www.labodata.com/media/category/img/origin/paraph.png";
  final PharmacieCalls pharmacieCalls = PharmacieCalls();
  PharmacieBloc() : super(PharmacieInitial()) {
    on<AddPharmacie>((event, emit) async {
      emit(PharmacieLoading());
      pharmacie = event.pharmacie;
      await pharmacieCalls.createPharmacie(event.pharmacie);
      emit(PharmacieReady(pharmacie: pharmacie!));
    });
    on<GetPharmacie>((event, emit) async {
      try {
        pharmacie = await pharmacieCalls.getPharmacie();
        images = pharmacie!.images;
        lgo = pharmacie!.lgoName;
        lgoImage = pharmacie!.lgoImage;
        emit(PharmacieReady(pharmacie: pharmacie!));
      } catch (e) {
        emit(PharmacieFailed());
      }
    });
  }
}
