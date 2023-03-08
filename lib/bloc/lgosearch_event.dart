part of 'lgosearch_bloc.dart';

abstract class LgosearchEvent extends Equatable {
  const LgosearchEvent();

  @override
  List<Object> get props => [];
}
class GetAllLgos extends LgosearchEvent {
  final String input;
 const GetAllLgos({
    required this.input,
  });
}