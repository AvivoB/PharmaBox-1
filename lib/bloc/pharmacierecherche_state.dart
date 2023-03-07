part of 'pharmacierecherche_bloc.dart';

@immutable
abstract class PharmacierechercheState {}

class PharmacierechercheInitial extends PharmacierechercheState {}

class ExplorerPharmacieReady extends PharmacierechercheState{
  List<Pharmacie> pharmacies;
  ExplorerPharmacieReady({required this.pharmacies});
}