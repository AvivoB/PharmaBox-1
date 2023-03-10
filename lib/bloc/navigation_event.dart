// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavItemClicked extends NavigationEvent {
  final int currentIndex;
  const NavItemClicked({
    required this.currentIndex,
  });
}
