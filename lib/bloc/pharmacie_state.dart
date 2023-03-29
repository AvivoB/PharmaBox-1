part of 'pharmacie_bloc.dart';

@immutable
abstract class PharmacieState {}

class PharmacieInitial extends PharmacieState {}

class PharmacieReady extends PharmacieState {
  final Pharmacie pharmacie;
  PharmacieReady({required this.pharmacie});
}

class PharmacieFailed extends PharmacieState {}
class PharmacieLoading extends PharmacieState {}

