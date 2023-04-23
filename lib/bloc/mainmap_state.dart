// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'mainmap_bloc.dart';

@immutable
abstract class MainmapState {
  final List<MarkerModel> models;
   MainmapState({
    required this.models,
  });
}

class MainmapInitial extends MainmapState {
  MainmapInitial({required super.models});
}

class ResultsLoading extends MainmapState {
  ResultsLoading({required super.models});
}

class ResultsReady extends MainmapState {
  ResultsReady({required super.models});
  
}
