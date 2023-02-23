part of 'groupement_bloc.dart';

abstract class GroupementState extends Equatable {
  const GroupementState();
  
  @override
  List<Object> get props => [];
}

class GroupementInitial extends GroupementState {}
class GroupementsReady extends GroupementState {
  final List<Groupement> groupements;
  GroupementsReady({required this.groupements});
}
class GroupementsLoading extends GroupementState{}