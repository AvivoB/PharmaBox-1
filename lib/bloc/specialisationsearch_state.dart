part of 'specialisationsearch_bloc.dart';

abstract class SpecialisationsearchState extends Equatable {
  const SpecialisationsearchState();
  
  @override
  List<Object> get props => [];
}

class SpecialisationsearchInitial extends SpecialisationsearchState {}

class SpecialisationsearchReady extends SpecialisationsearchState {
  final List<Groupement> groupements;
  SpecialisationsearchReady({required this.groupements});
}
class SpecialisationsearchLoading extends SpecialisationsearchState{}