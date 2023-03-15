part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();
  
  @override
  List<Object> get props => [];
}

class NavigationInitial extends NavigationState {}
class ExplorerState extends NavigationState{}
class PharmaJobTituState extends NavigationState{}
class PharmaJobNonTituState extends NavigationState{}
class ProfileState extends NavigationState{}
