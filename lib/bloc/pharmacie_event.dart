part of 'pharmacie_bloc.dart';

@immutable
abstract class PharmacieEvent {}

class AddPharmacie extends PharmacieEvent {
  final Pharmacie pharmacie;
  AddPharmacie({
    required this.pharmacie,
  });
}
class GetAllPharmacies extends PharmacieEvent{
}
