import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmabox/firebase/main_map_service.dart';
import 'package:pharmabox/model/user_models/marker_model.dart';

import '../utils/map_utils.dart';

part 'mainmap_event.dart';
part 'mainmap_state.dart';

class MainmapBloc extends Bloc<MainmapEvent, MainmapState> {
  MainMapService mainMapService = MainMapService();
  MainmapBloc() : super(MainmapInitial(models:const [])) {
    on<GetMarkersOnAddress>((event, emit) async {
      emit(ResultsLoading(models:const []));
      List<MarkerModel> markers =
          await mainMapService.getCloseLocationResults(event.address);
      emit(ResultsReady(models: markers));
    });
     on<GetMemberMarkersOnAddress>((event, emit) async {
      emit(ResultsLoading(models:const []));
      List<MarkerModel> markers =
          await mainMapService.getCloseLocationMmebres(event.address);
      emit(ResultsReady(models: markers));
    });
    on<GetOffresMarkersOnAddress>((event, emit) async {
      emit(ResultsLoading(models:const []));
      List<MarkerModel> markers =
          await mainMapService.getCloseOffresResults(event.address);
      emit(ResultsReady(models: markers));
    });
  }
}
