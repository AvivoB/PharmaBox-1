part of 'pharmacie_bloc.dart';

@immutable
abstract class PharmacieState {}

class PharmacieInitial extends PharmacieState {}

class PharmacieReady extends PharmacieState {
  final List<Pharmacie?> pharmacies;
  PharmacieReady({required this.pharmacies});
}

class PharmacieFailed extends PharmacieState {}
