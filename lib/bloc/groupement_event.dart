// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'groupement_bloc.dart';

abstract class GroupementEvent extends Equatable {
  const GroupementEvent();

  @override
  List<Object> get props => [];
}

class GetAllGroupements extends GroupementEvent {
  final String input;
 const GetAllGroupements({
    required this.input,
  });
}
