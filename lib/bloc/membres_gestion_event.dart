// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'membres_gestion_bloc.dart';

abstract class MembresGestionEvent extends Equatable {
  const MembresGestionEvent();

  @override
  List<Object> get props => [];
}

class DeleteMembre extends MembresGestionEvent {
  final NonTitulaire membre;
  const DeleteMembre({
    required this.membre,
  });
}

class AddMembre extends MembresGestionEvent {
  final NonTitulaire membre;
  const AddMembre({
    required this.membre,
  });
}
