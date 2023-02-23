part of 'groupement_bloc.dart';

abstract class GroupementEvent extends Equatable {
  const GroupementEvent();

  @override
  List<Object> get props => [];
}
class GetAllGroupements extends GroupementEvent{
}
