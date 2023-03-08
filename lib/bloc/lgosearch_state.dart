part of 'lgosearch_bloc.dart';

abstract class LgosearchState extends Equatable {
  const LgosearchState();
  
  @override
  List<Object> get props => [];
}

class LgosearchInitial extends LgosearchState {}
class LgosearchReady extends LgosearchState {
  final List<Groupement> groupements;
  LgosearchReady({required this.groupements});
}
class LgosearchLoading extends LgosearchState{}