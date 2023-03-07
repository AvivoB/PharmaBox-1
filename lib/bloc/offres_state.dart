part of 'offres_bloc.dart';

abstract class OffresState extends Equatable {
  const OffresState();

  @override
  List<Object> get props => [];
}

class OffresInitial extends OffresState {}

class AddOffreFailed extends OffresState {}

class OffreSuccess extends OffresState {}

class OffresReady extends OffresState {
  final List<Offre> offres;
  const OffresReady({required this.offres});
}
class FilteredOffresReady extends OffresState{
  final List<OffreCard> offres;
  const FilteredOffresReady({required this.offres});
}
class ExplorerOffresReady extends OffresState{
  final List<OffreCard> offres;
  const ExplorerOffresReady({required this.offres});
}
