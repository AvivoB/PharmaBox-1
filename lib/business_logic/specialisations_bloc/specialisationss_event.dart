part of 'specialisations_bloc.dart';

abstract class SpecialisationsEvent {}

class AddLocalSpecialisation extends SpecialisationsEvent {
   Specialisation _specialisation;
  AddLocalSpecialisation({
    required Specialisation specialisation,
  }) : _specialisation = specialisation;
}

class RemoveLocalSpecialisation extends SpecialisationsEvent {
   Specialisation _specialisation;
  RemoveLocalSpecialisation({required Specialisation specialisation})
      : _specialisation = specialisation;
}

class AddRemoteSpecialisation extends SpecialisationsEvent {
   Specialisation _specialisation;
  AddRemoteSpecialisation({required Specialisation specialisation})
      : _specialisation = specialisation;
}

class RemoveRemoteSpecialisation extends SpecialisationsEvent {
   Specialisation _specialisation;
  RemoveRemoteSpecialisation({
    required Specialisation specialisation,
  }) : _specialisation = specialisation;
}

class UpdateSpecialisation extends SpecialisationsEvent {
   Specialisation _specialisation;
  UpdateSpecialisation({required Specialisation specialisation})
      : _specialisation = specialisation;
}
class InitialiseSpecialisation extends SpecialisationsEvent {}
