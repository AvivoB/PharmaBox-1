part of 'specialisationsearch_bloc.dart';

abstract class SpecialisationsearchEvent extends Equatable {
  const SpecialisationsearchEvent();

  @override
  List<Object> get props => [];
}
class GetAllSpecialisations extends SpecialisationsearchEvent {
  final String input;
 const GetAllSpecialisations({
    required this.input,
  });
}