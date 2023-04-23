part of 'verifier_membre_bloc.dart';

abstract class VerifierMembreState {
  const VerifierMembreState();
}

class VerifierMembreInitial extends VerifierMembreState {}

class MembreExiste extends VerifierMembreState {}

class MembreAbsent extends VerifierMembreState {}
