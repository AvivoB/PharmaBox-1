// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'verifier_membre_bloc.dart';

abstract class VerifierMembreEvent extends Equatable {
  const VerifierMembreEvent();

  @override
  List<Object> get props => [];
}

class VerifierMembre extends VerifierMembreEvent {
  final NonTitulaire membre;
  const VerifierMembre({
    required this.membre,
  });
}
